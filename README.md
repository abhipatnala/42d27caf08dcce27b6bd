# README


endpoint: 'api/robot/:id/orders'

test data: 
 input: { "commands": ["REPORT", "MOVE","PLACE 1,2,EAST", "REPORT"] }
 output: { "location": [ 1, 2,"EAST"]}
 
 input: { "commands": ["MOVE","PLACE 1,2,EAST", "LEFT","LEFT","RIGHT","RIGHT", "REPORT"]}
 output: { "location": [ 1, 2,"EAST"] }
