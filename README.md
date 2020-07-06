# NYC SAT Score Analysis in R

## Plan:
With this project I am looking to investigate the relationship between NYC school zip codes, household income, and mean SAT scores. I will do this by first importing spreadsheets containing the average SAT score and physical address for each school. Next I will join these two data tables together and group by zip code. From here I will find the mean SAT score per zip code and analyse the distribution. For the zipcodes with the top 3 highest and lowest scores I will add the average income to see if there are any patterns.

My hypothesis is certain zip codes will have significantly higher SAT scores and incomes than others. 

## Results:

<img src="https://raw.githubusercontent.com/ericciarla/NYC_SAT_ANALYSIS/master/output/boxplot.png" width="500px"><img src="https://raw.githubusercontent.com/ericciarla/NYC_SAT_ANALYSIS/master/output/histogram.png" width="510px">
<p align="center">
  <img src="https://raw.githubusercontent.com/ericciarla/NYC_SAT_ANALYSIS/master/output/top3bottom3.png" width="700px">
</p>

### The analysis uncovers two things:
- The distribution of scores is not normal and has a right skew. 
- Zip codes with higher mean SAT scores will have higher average household incomes

## Notes:
The income data gathered from incomebyzipcode.com




