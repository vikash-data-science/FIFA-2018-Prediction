
library(caret)

data1 = read.csv("FootballData.csv",stringsAsFactors = FALSE)

# testing_data = data1[which(data1$year == 2018),]
# training_data = data1[which(data1$year < 2018),]

model <- train(Winning.team ~ home_team+away_team+Home_team_rank_2018+Away_team_rank_2018,data = data1,model = "rf")
testing_data = read.csv("testing_data.csv",stringsAsFactors = FALSE)

output = as.character(predict(model,testing_data))

quarter_finalist = output

semi_finalist_testing_data = read.csv("Semifinal_testing_data.csv",stringsAsFactors = FALSE)
Semi_finalist = as.character(predict(model,semi_finalist_testing_data))

# in the history of penalty shootout Sweden has more chance to win so we will keep Sweden as 
# semi finalist

Semi_finalist[4] = "Sweden"

Finalist_data = read.csv("Finalist.csv",stringsAsFactors = FALSE)
Finalist = as.character(predict(model,Finalist_data))

Winner_data = read.csv("Winner.csv",stringsAsFactors = FALSE)
Winner = as.character(predict(model,Winner_data))


final_output = data.frame(output,Semi_finalist,Finalist,Winner)
output = write.csv(final_output,"output.csv")
