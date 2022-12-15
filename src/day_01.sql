
Create Table public.food_calorie (
    food_calorie_id Int Not Null Generated Always As Identity,
    calories Int
);

Copy public.food_calorie (calories) From '/aoc2022_data/day_1.txt' With (Null '');

With cte As (
    SELECT  food_calorie_id
        ,   Lag(food_calorie_id) Over (Order By fc.food_calorie_id) As prev_food_calorie_id
    From public.food_calorie fc
    Where fc.calories Is Null
)
Select  c.food_calorie_id
    ,   Sum(fc.calories) As total_calories
From public.food_calorie fc
Inner Join cte c
    On fc.food_calorie_id > Coalesce(c.prev_food_calorie_id, 0)
    And fc.food_calorie_id < c.food_calorie_id
Group By c.food_calorie_id
Order By total_calories Desc

With cte As (
    SELECT  food_calorie_id
        ,   Lag(food_calorie_id) Over (Order By fc.food_calorie_id) As prev_food_calorie_id
    From public.food_calorie fc
    Where fc.calories Is Null
), cteElfCalories As (
    Select  c.food_calorie_id
        ,   Sum(fc.calories) As total_calories
    From public.food_calorie fc
    Inner Join cte c
        On fc.food_calorie_id > Coalesce(c.prev_food_calorie_id, 0)
        And fc.food_calorie_id < c.food_calorie_id
    Group By c.food_calorie_id
), cteRowNumber As (
    SELECT  cec.*
        ,   Row_Number() Over (Order By cec.total_calories Desc) As row_number
    From cteElfCalories cec
)
Select  Sum(crn.total_calories)
From cteRowNumber crn
Where crn.row_number <= 3