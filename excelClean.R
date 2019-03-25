library(tidyxl)
library(unpivotr)

dataset <- xlsx_cells('data/attendance.xlsx') %>%
  filter(row!=1, row != 4, row < 65)
blah1 <- dataset %>% behead('N', tophead) %>% behead('N', header) %>%
  behead('W',State) %>%
  fill(tophead) %>% fill(header) %>%
  mutate(var_head = ifelse(col %% 2 == 0, 'stats','se')) %>%
  select(row,var_head, numeric, tophead, header, State) %>%
  spread(var_head, numeric) %>% select(-row)

blah2 <- blah1 %>%
  mutate(State = str_remove(State, '\\.+'),
         State = str_trim(State)) %>%
  filter(!is.na(State))
blah2 %>% filter(header == 'Average hours in school day', tophead == 'Elementary schools') ->blah3
blah3 %>% filter(State != 'United States') %>%
  ggplot(aes(x = State, y = stats))+
    geom_point() +
    geom_hline(yintercept = overal_perc) +
    theme_bw()+
    theme(axis.text.x = element_text(angle=45, hjust=1)) +
    ylab('Hours')


dataset2 <- xlsx_cells('data/classlist.xlsx')
formats <- xlsx_formats('data/classlist.xlsx')

format_id <- dataset2$local_format_id
dataset2$font_color <- formats$local$font$color$rgb[format_id]
dataset2$bg_color <- formats$local$fill$patternFill$fgColor$rgb[format_id]
dataset2 %>% filter(font_color=='FFFF0000') %>% select(row, col, data_type, character, font_color) %>% mutate(row=2,col=1:8) -> marked1
dataset2 %>% filter(bg_color == 'FFFFC000') %>% select(row, col, data_type, character, font_color) %>% mutate(row = 1, col=1:8) -> headers1

rbind(headers1, marked1) %>% behead('N',header) %>% select(row, data_type, character, header) %>% spatter(header) %>% select(-row)

d1 <- dataset2 %>% filter(row %% 2 == 1) %>% behead('N', header) %>% mutate(row = (row+1)/2)
d2 <- dataset2 %>% filter(row %% 2 == 0) %>% behead('N', header) %>% mutate(row = row/2, col = col+4)
d <- rbind(d1,d2)
final_data <- d %>% select(row, data_type, numeric, character, header) %>% spatter(header) %>% select(-row, -numeric) %>%
  set_names(make.names(names(.))) %>%
  select(Student.Name, everything())
