# Household Income, Education, and Employment Analysis

![R Version](https://img.shields.io/badge/R-4.3.1+-blue.svg)
![Tidyverse](https://img.shields.io/badge/dplyr-tidyverse-orange.svg)

## Project Overview
This project analyzes socioeconomic trends using data from the **Annual Household Expenditure and Income Survey (AHIES) 2023**. It explores regional disparities in income, education, employment, and household characteristics across Ghana.

**Key Questions**:
- Which regions have the highest average wages and household sizes?
- What is the urban/rural demographic split?
- What are the most common occupations and education levels?
- How many workers earn minimum wage?

---

## Dataset
**Source**: [AHIES 2023](https://www.statsghana.gov.gh/) (Annual Household Expenditure and Income Survey)  
**Original Size**: 3,564 observations × 608 variables  
**Selected Variables**:

| Variable          | Description                          | Type      |
|-------------------|--------------------------------------|-----------|
| `hhid`            | Household ID                         | Numeric |
| `s3aq23hhid`      | Household member ID                  | Numeric |
| `region`          | Respondent's region                  | Categorical |
| `s1aq1`           | Gender (Male/Female)                 | Categorical |
| `s1aq4y`          | Age                                  | Numeric     |
| `urbrur`          | Locality (Urban/Rural)               | Categorical |
| `s4aq55a`         | Primary job wage (GHS)               | Numeric     |
| `s4gq13c`         | Earns minimum wage (Yes/No)          | Categorical |
| `s1aq5`           | Marital Status              | Categorical |
| `s2aq3`           | Highest education level              | Categorical |
| `s2aq11a29`           | Lump Sum (Education)              | Numeric |
| `s4aq2`           | Total hours worked a week              | Numeric |
| `s4aq40a1`           | Main Occupation              | Categorical |

---

## Installation & Setup

### Dependencies
- **R** (v4.3.1 or newer)
- **R Packages**:
  ```r
  install.packages("tidyverse")
  ```
### Steps
1. Clone this repository:
   ```bash
   git clone https://github.com/kcnewman/ahies-trends.git
   ```
2. Place the raw dataset (`AHIES.csv`) in the project directory.
3. Run the main script:
   ```bash
   Rscript main.R
   ```
---
## Code Structure
1. Data Cleaning
   * Selected 15 variables and removed empty rows.
   * Fixed typos in the `urbrur` column.
    
2. Aggregation
   Grouped data by region and calculated:
   * Household metrics (size, count)
   * Demographics (gender ratio, mean age)
   * Employment (average wage, modal occupation)
   * Education (most common education level)
  
---
## Contact 
For questions or collaborations, contact Newman Kelvin at 
[newmankelvin14@gmail.com].
