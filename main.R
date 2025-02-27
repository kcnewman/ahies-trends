library(tidyverse)

# Loading the dataset
ahies <- read.csv('C:/Users/KCN ALPHA/Desktop/projects/15-r-projects/10%AHIES.csv')

# Data exploration
dim(ahies)
head(ahies)
summary(aies)

'Dataset used in this project is the AHIES 2023 dataset. This is a panel data 
at the national and regional levels on expenditure, income and living conditions
of households and individuals.

The dataset contains 3564 observations and 608 variables
For this analysis, not all these variables are needed hence the following were 
selected
'

# Isolating the necessary columns and removing columns with all variables having
# no entries
df <- ahies %>% 
  select(region,s1aq1,s1aq4y,s1aq4y,urbrur,s1aq5,s2aq3,s2aq11a29,s4aq2,
         s4aq40a1,s4aq43m,s4aq49,s4aq55a,s4gq13c,hhid,s3aq23hhid)
  
'
The description of the columns are provided in the AHEIS microdata. 
The ones used in this project are;
1. s1aq1 -> Sex of the respondent
2. s1aq4y -> Age
3. urbrur -> Locality type
4. s1aq5 -> Marital Status
5. s2aq3 -> Highest Level of Education
6. s2aq11a29 -> Lump Sum (Education)
7. s4aq2 -> Total Hours Worked in a week (Primary)
8. s4aq40a1 -> Main Occupation (Primary)
9. s4aq43m -> How long respondent has been on the Job (Primary)
10. s4aq49 -> Do you go on holidays on the job?
11. s4aq55a -> Wage of Primary Job
12.  s4gq13c -> Is it minimum wage?
13. hhid -> Household ID
14. s3aq23hhid -> Household member ID
15. region -> Region of the respondent
'

# Doing some cleaning
# Fixing type in the spelling of urban
df <- df %>% 
  mutate(urbrur = str_replace(urbrur,"Urbanb","Urban"))


# Aggregating data for insights
# Defining a modal function
calculate_mode <- function(x) {
  ux <- unique(na.omit(x))
  if (length(ux)==0){
    return(NA)
  }
  ux[which.max(tabulate(match(x,ux)))]
}


aggregated_df <- df %>% 
  group_by(region) %>% 
  summarise(
    total_respondents = n(),
    # Household
    total_households = n_distinct(hhid),
    avg_household_size = n()/n_distinct(hhid),
    
    # Demographics
    mean_age = mean(s1aq4y, na.rm = TRUE),
    total_males = sum(s1aq1 == "Male", na.rm = TRUE),
    total_females = sum(s1aq1 == "Female", na.rm = TRUE),
    total_rural = sum(urbrur=='Rural', na.rm = TRUE),
    total_urban = sum(urbrur=='Urban', na.rm = TRUE),
    most_relationship_type = calculate_mode(s1aq5),
    
    # Education
    modal_education = calculate_mode(s2aq3),
    
    # Employment
    avg_weekly_hours = mean(s4aq2, na.rm = TRUE),
    modal_occupation = calculate_mode(s4aq40a1),
    min_wage = min(s4aq55a, na.rm = TRUE),
    average_wage = mean(s4aq55a, na.rm = TRUE),
    max_wage = max(s4aq55a, na.rm = TRUE),
    prop_min_wage = mean(s4gq13c == "Yes", na.rm = TRUE)
  )

# Identifying key concepts
#1. Top region by total households
top_households <- aggregated_df %>%
  arrange(desc(total_households)) %>%
  select(region, total_households) %>%
  head(5)

#2. Top regions by average wage
top_wage <- aggregated_df %>% 
  arrange(desc(average_wage)) %>% 
  select(region,average_wage) %>% 
  head(5)

#3. Top region by education spending
edu_spending <- df %>% 
  group_by(region) %>% 
  summarise(total_edu_spending=sum(s2aq11a29,na.rm = TRUE)) %>% 
  arrange(desc(total_edu_spending)) %>% 
  head(5)

#4. Urban vs Rural Proportion
urb_rur_pro <- aggregated_df %>% 
  mutate(prop_urban = total_urban/total_respondents,
         prop_rural = total_rural/total_respondents) %>% 
  select(region, prop_urban,prop_rural)

#5. Minimum wage proportion
min_wage_prop <- aggregated_df %>% 
  select(region, prop_min_wage)

# Creating Vectors and Matrices
avg_wage_v <- aggregated_df$average_wage
names(avg_wage_v) <- aggregated_df$region

hse_size_v <- aggregated_df$avg_household_size
names(hse_size_v) <- aggregated_df$region

# A matrix of educ. vs wage
edu_wage_mat <- matrix(
  c(aggregated_df$modal_education, aggregated_df$average_wage),
  nrow = nrow(aggregated_df),
  dimnames = list(aggregated_df$region, c('Education Mode', 'Avg Wage'))
)  


# Putting everything into a list
results_list <- list(
  top_households=top_households,
  top_wage=top_wage,
  urban_rural_prop=urb_rur_pro,
  min_wage_prop=min_wage_prop,
  modal_marital_status=aggregated_df$most_relationship_type,
  vectors = list(
    avg_wage = avg_wage_v,
    household_size = hse_size_v),
  matrices = list(
    education_wage=edu_wage_mat
  )
    
  )

