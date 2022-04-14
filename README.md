# sunmi-flutter-sdk
SUNMI hardware sdk for Flutter.

## Print Module

### 1. initPrinter()
Initialize the sunmi printer.
- Parameter
    - None
- Return
    - success: a string message field.
    - error: string code field and message field.

### 2. getPrinterStatus()
Get printer status.
- Parameter
    - None
- Return
    - success(): return an int type status field, status:
        - 1 - The printer works normally
        - 2 - The printer is preparing
        - 3 - Abnormal communication
        - 4 - Out of pape
        - 5 - Overheating
        - 6 - Open the lid
        - 7 - Cut abnormal
        - 8 - Cut recovery
        - 9 - No mark detected
        - 505 - Printer not detected
        - 507 - Printer firmware upgrade failed

### 3. reset()
Reset the printer logic program (for example: layout, bold and other style settings), but does not clear the data in the buffer area, so incomplete print jobs will continue after resetting.
- Parameter
    - None
- Return
    - success: a string message field.
    - error: string code field and message field.

### 4. setBold()
Set the font bold, the default is false.
- Parameter
    - bool, true: set fond bold, false: cancel font bold.
- Return
    - success: a string message field.
    - error: string code field and message field.

### 5. setFontSize()
Set font size.
- Parameter
    - int, font size.
- Return
    - success: a string message field.
    - error: string code field and message field.

### 6. setAlignment()
Set alignment mode.
- Parameter
    - int, alignment mode.
        - 0 - left
        - 1 - center
        - 2 - right
- Return
    - success: a string message field.
    - error: string code field and message field.

### 7. setRowHeight()
Set the line spacing for print.
- Parameter
    - int, row height.
- Return
    - success: a string message field.
    - error: string code field and message field.

### 8. printText()
Print text.
- Parameter
    - String, print data.
- Return
    - success: a string message field. The processing result returned by success() method refers to the execution result of the command processing, not the processing result of printing out the paper.
    - error: string code field and message field.

### 9. printImage()
Print picture.
- Parameter
    - Uint8List, the byte array of the picture.
- Return
    - success: a string message field. The processing result returned by success() method refers to the execution result of the command processing, not the processing result of printing out the paper.
    - error: string code field and message field.

**Note: Because SUNMI's V series and P series use 58mm printers. If you want the printed image to be centered, please make an image with a width of 384px.**

### 10. printBarcode()
Print barcode.
- Parameter
    - String, barcode data.
    - int, barcode type, value 0-8.
        - 0 - UPC-A
        - 1 - UPC-E
        - 2 - JAN13(EAN13)
        - 3 - JAN8(EAN8)
        - 4 - CODE39
        - 5 - ITF
        - 6 - CODABAR
        - 7 - CODE93
        - 8 - CODE128
    - int, barcode height, value 1-255, default: 162.
    - int, barcode width, value 2-6, default: 2.
    - int, text position, value 0-3.
        - 0 - Do not print text
        - 1 - The text is on the barcode
        - 2 - The text is under the barcode
        - 3 - Barcodes are printed up and down
- Return
    - success: a string message field. The processing result returned by success() method refers to the execution result of the command processing, not the processing result of printing out the paper.
    - error: string code field and message field.

### 11. printQRCode()
Print QRCode.
- Parameter
    - String, qrcode data.
    - int, qrode block size, unit: point, value 4 to 16.
    - int, qrcode error correction level.
        - 0 - Error correction level L
        - 1 - Error correction level M
        - 2 - Error correction level Q
        - 3 - Error correction level H
- Return
    - success: a string message field. The processing result returned by success() method refers to the execution result of the command processing, not the processing result of printing out the paper.
    - error: string code field and message field.

### 12. printTable()
Print Table.
- Parameter
    - List\<String>, an array of text strings for each column.
    - List\<int>, array of column widths, calculated in English characters, each middle character occupies two English characters, and each width is greater than 0.
    - List\<int>, alignment of each column: 0 on the left, 1 on the center, and 2 on the right.
- Return
    - success: a string message field. The processing result returned by success() method refers to the execution result of the command processing, not the processing result of printing out the paper.
    - error: string code field and message field.

### 13. printLine()
Print blank lines.
- Parameter
    - int, number of print lines.
- Return
    - success: a string message field. The processing result returned by success() method refers to the execution result of the command processing, not the processing result of printing out the paper.
    - error: string code field and message field.

### 14. enterPrinterBuffer()
Start transaction print.

The transaction printing mode is suitable for the needs to control the printing content and get the printing result feedback (whether to print out a small ticket). This mode is equivalent to the establishment of a transaction queue buffer. When the developer enters the transaction printing mode, it will be opened. You can add a printing method to a transaction queue. At this time, the printer will not print the content immediately. After the transaction is submitted, the printer will execute the tasks in the queue one by one. After the execution is completed, you will get the result feedback of the transaction.
- Parameter
    - None
- Return    
    - None

### 15. exitPrinterBuffer()
Exit and commit the transaction to print.
- Parameter
    - None
- Return
    - success: a string message field, means print success.
    - error: string code field and message field, means print failure.

## Scan Module

### 1. startScan()
start scan.
- Parameter
    - None
- Return
    - Map, including value and type data of string type.

## Devices Mudule

### 1. getSystemParameters()
Get information about the device.
- Parameter
    - String, device related parameter name
        - deviceCode
        - deviceModel
        - deviceBrand
        - serialNumber
        - systemVersionName
        - systemVersionCode
        - debugMode
        - PN
        - terminalUniqueSerialNumber
        - firmwareVersion
        - hardwareVersion
        - reserved
- Return
    - String, value corresponding to the parameter.

### 2. enableScreenMonopoly()
Enable screen monopoly mean screen exclusive, power key disabled, volume key disabled, system status bar disabled and system navigation bar disabled. 
- Parameter
    - None
- Return    
    - None

### 3. disableScreenMonopoly()
Cancel screen monopoly.
- Parameter
    - None
- Return    
    - None

### 4. enableStatusBarDropDown()
Allow status bar drop down.
- Parameter
    - None
- Return    
    - None    

### 5. disableStatusBarDropDown()
Disable status bar drop down.
- Parameter
    - None
- Return    
    - None

### 6. showNavigationBar()
Show navigation bar.
- Parameter
    - None
- Return    
    - None

### 7. hideNavigationBar()
Hide navigation bar.
- Parameter
    - None
- Return    
    - None

## Remark
This Demo is only suitable for SUNMI P series and V series products, not suitable for other products. If you have other requirements, please contact me.

Email: chuwuwang@126.com








