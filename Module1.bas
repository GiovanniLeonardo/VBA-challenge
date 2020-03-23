Attribute VB_Name = "Module1"
Sub Ticker()


Dim WS As Worksheet
For Each WS In Worksheets
    

'Create variables to hold value
    Dim StockSymbol As String
    Dim OpenPrice As Double
    Dim ClosePrice As Double
    Dim OpenPriceSymbol As Double
    Dim SymbolTotal As Double
    Dim PercentChange As Double
    Dim SummaryRow As Integer
    OpenPriceSymbol = 2
    
    SymbolTotal = 0 'Set start
    SummaryRow = 2  'Track each ticker
    
'Set summary table header
    WS.Range("I1").Value = "Stock Symbol"
    WS.Range("J1").Value = "Yearly Change"
    WS.Range("k1").Value = "Percent Change"
    WS.Range("l1").Value = "Total Stock Volume"
        
    
'Create For loop through each ticker
    Lastrow = WS.Cells(Rows.Count, 1).End(xlUp).Row
        For i = 2 To Lastrow
    
'Check if still within the same StockSymbol
    If WS.Cells(i + 1, 1).Value <> WS.Cells(i, 1).Value Then
 
        'Then Calc YearChange
        YearChange = ClosePrice - OpenPrice
        WS.Cells(i, 10).Value = YearChange
        
        OpenPrice = WS.Cells(OpenPriceSymbol, 3).Value
        StockSymbol = WS.Cells(i, 1).Value                'SET Ticker Symbol
        SymbolTotal = SymbolTotal + WS.Cells(i, 7).Value  'ADD Total
        ClosePrice = WS.Cells(i, 6).Value                 'GET Total Price

'IF YearChange is negative or positive
            If WS.Cells(i, 10).Value > 0 Then
                WS.Cells(i, 10).Interior.ColorIndex = 4
            Else
                WS.Cells(i, 10).Interior.ColorIndex = 3
            End If
        
'Calculate PercentChange
        If OpenPrice = 0 Then
            PercentChange = 0
        Else
            PercentChange = YearChange / OpenPrice
        End If
        
'OUTPUT to summary table
        WS.Range("I" & SummaryRow).Value = StockSymbol
        WS.Range("J" & SummaryRow).Value = YearChange
        WS.Range("K" & SummaryRow).Value = PercentChange
        WS.Range("K" & SummaryRow) = Format(PercentChange, "Percent")
        WS.Range("L" & SummaryRow).Value = SymbolTotal
    
'Conditional format to indicate postive (green) or negative (red) change using VBA Color Index
        If WS.Cells(SummaryRow, 10).Value > 0 Then
            WS.Cells(SummaryRow, 10).Interior.ColorIndex = 4
        Else
            WS.Cells(SummaryRow, 10).Interior.ColorIndex = 3
        End If
        
'Add 1 to the summary table row
        SummaryRow = SummaryRow + 1
        
'RESET StockSymbol Total
        SymbolTotal = 0
        
'RESET OpenPriceSymbol to proper number
        OpenPriceSymbol = (i + 1)
        
    Else

        'ADD to the StockSymbol Total
        SymbolTotal = SymbolTotal + WS.Cells(i, 7).Value
        
    End If
    
  Next i


Next WS

End Sub
