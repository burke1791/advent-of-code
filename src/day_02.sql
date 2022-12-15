
Create Table public.rps_strategy (
    rps_strategy_id Int Not Null Generated Always As Identity,
    opponent Char(1) Not Null,
    you Char(1) Not Null
);

Copy public.rps_strategy (opponent, you) From '/aoc2022_data/day_2.txt' (Delimiter (' '))

/*
A/X: Rock
B/Y: Paper
C/Z: Scissors

Rock: 1
Paper: 2
Scissors: 3

Win: 6
Draw: 3
Loss: 0
*/

With cte As (
    Select  s.opponent
        ,   Case s.opponent
                When 'A' Then 'Rock'
                When 'B' Then 'Paper'
                When 'C' Then 'Scissors'
            End As opponent_play
        ,   s.you
        ,   Case s.you
                When 'X' Then 'Rock'
                When 'Y' Then 'Paper'
                When 'Z' Then 'Scissors'
            End As you_play
        ,   Case When s.you = 'X' Then
                    Case s.opponent
                        When 'A' Then 'D'
                        When 'B' Then 'L'
                        When 'C' Then 'W'
                    End
                When s.you = 'Y' Then
                    Case s.opponent
                        When 'A' Then 'W'
                        When 'B' Then 'D'
                        When 'C' Then 'L'
                    End
                When s.you = 'Z' Then
                    Case s.opponent
                        When 'A' Then 'L'
                        When 'B' Then 'W'
                        When 'C' Then 'D'
                    End
            End As result
    From public.rps_strategy s
), ctePoints As (
    Select  c.*
        ,   Case c.result
                When 'W' Then 6
                When 'D' Then 3
                When 'L' Then 0
            End As result_points
        ,   Case c.you
                When 'X' Then 1
                When 'Y' Then 2
                When 'Z' Then 3
            End As play_points
    From cte c
)
SELECT  Sum(p.result_points + p.play_points)
From ctePoints p


/*
X: lose
Y: draw
Z: Win
*/


With cte As (
    Select  s.opponent
        ,   Case s.opponent
                When 'A' Then 'Rock'
                When 'B' Then 'Paper'
                When 'C' Then 'Scissors'
            End As opponent_play
        ,   s.you
        ,   Case s.opponent
                When 'A' Then
                    Case s.you
                        When 'X' Then 'Scissors'
                        When 'Y' Then 'Rock'
                        When 'Z' Then 'Paper'
                    End
                When 'B' Then
                    Case s.you
                        When 'X' Then 'Rock'
                        When 'Y' Then 'Paper'
                        When 'Z' Then 'Scissors'
                    End
                When 'C' Then
                    Case s.you
                        When 'X' Then 'Paper'
                        When 'Y' Then 'Scissors'
                        When 'Z' Then 'Rock'
                    End
            End As you_play
        ,   Case When s.you = 'X' Then 'L'
                When s.you = 'Y' Then 'D'
                When s.you = 'Z' Then 'W'
            End As result
    From public.rps_strategy s
), ctePoints As (
    Select  c.*
        ,   Case c.result
                When 'W' Then 6
                When 'D' Then 3
                When 'L' Then 0
            End As result_points
        ,   Case c.you_play
                When 'Rock' Then 1
                When 'Paper' Then 2
                When 'Scissors' Then 3
            End As play_points
    From cte c
)
SELECT  Sum(p.result_points + p.play_points)
From ctePoints p