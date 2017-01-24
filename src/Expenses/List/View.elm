module Expenses.List.View exposing (root)

import Html exposing (..)


-- import Html.App exposing (map)

import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Date
import String
import Types exposing (..)
import Expenses.List.Types exposing (..)
import Budgets.View as Budgets
import Utils.Expenses exposing (getTotal)
import Utils.Numbers exposing (formatAmount, toFloatPath)


root : User -> Model -> Html Msg
root user model =
    let
        filter expense =
            Just expense.budgetId == model.buttons.currentBudgetId || model.buttons.currentBudgetId == Nothing

        expenses =
            List.filter filter model.expenses

        expensesTotal =
            getTotal expenses |> formatAmount
    in
        div []
            [ viewExpenseForm model
            , viewBudgets user model.expenses model
            , weekHeader model expensesTotal
            , viewExpenseList expenses expensesTotal
            ]


expenseItemLinkText : Expense -> String
expenseItemLinkText expense =
    let
        title =
            expense.budgetName
                ++ if String.length expense.comment > 0 then
                    " ***"
                   else
                    ""
    in
        title
