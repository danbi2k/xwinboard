var spreadSheetHandlesArray = new Array();
function mtSpreadSheet(strSpreadSheetID, strEditCellID, strColGroupID, strFontSize) {
	this._selected_cell	= null;
	this._row = 0;
	this._col = 0;
	this._lastCellValue = 0;

	this._myEditCell	= document.all[strEditCellID];
	this._mySpreadSheet	= document.all[strSpreadSheetID];
	this._myColGroup	= document.all[strColGroupID];
	if (this._mySpreadSheet.rows(0)) {
		this._mySpreadSheet.cols = this._mySpreadSheet.rows(0).cells.length;
	}
	else {	
		this._mySpreadSheet.cols = 5;
	}
    this._fontSize = strFontSize;
	if (this._fontSize > 0) {
		this._mySpreadSheet.style.fontSize = this._fontSize;
	}
	this._fontFamily = "Helvetica,Verdana,Arial,Geneva";
	this._mySpreadSheet.style.fontFamily = this._fontFamily;
	this._rowValues = new Array(this._mySpreadSheet.cols);
	this._oldRowValues = new Array(this._mySpreadSheet.cols);
	this._targetedRow = -1;
	this.setInitialNumberColumns	= setInitialNumberColumns;
	this.spreadSheetClick			= spreadSheetClick;
	this.handle_data				= handle_data;
	this.setSpreadSheetResize		= setSpreadSheetResize;
	this._internalSetSpreadSheetResize	= _internalSetSpreadSheetResize;
	this.checkArgument				= checkArgument;
	this.setCellFixedSize			= setCellFixedSize;
	this._internalSetCellFixedSize	= _internalSetCellFixedSize;
	this.UpdateSpreadSheetColumns	= UpdateSpreadSheetColumns;
	this.UpdateSpreadSheetRows		= UpdateSpreadSheetRows;
	this.setClick					= setClick;
	this.handleSpreadSheetResize	= handleSpreadSheetResize;
	this.applyColumnFunction		= applyColumnFunction;
	this.setFunctionName			= setFunctionName;
	this.getNumberRows				= getNumberRows;
	this.getNumberColumns			= getNumberColumns;
	this.retrieveRowValues			= retrieveRowValues;
	this.retrieveColumnValues		= retrieveColumnValues;
	this.retrieveCellValue			= retrieveCellValue;
	this.setCellValue			    = setCellValue;
	this.currRow				    = currRow;
	this.currCol				    = currCol;
	this.lastCellValue			    = lastCellValue;
	this.restoreCellValue			= restoreCellValue;
	this._click_callback			= null;
	this._typeOfColumnFunction		= "";
	this.getRowValues               = getRowValues;
	this.getTargetedRow             = getTargetedRow;
	this.numOfModifiedCols          = numOfModifiedCols;
	spreadSheetHandlesArray[spreadSheetHandlesArray.length] = this;
}
function currRow() {
	return this._row;
}
function currCol() {
	return this._col;
}
function lastCellValue() {
	return this._lastCellValue;
}
function getRowValues() {
	return this._rowValues;
}
function getTargetedRow() {
	return this._targetedRow;
}
function restoreCellValue() {
	if (this._targetedRow != -1) {
		for (i=0; i<this._oldRowValues.length; i++) {
			 if (this._oldRowValues[i]) {
				 this.setCellValue(this._targetedRow, i, this._oldRowValues[i]);
                 this._oldRowValues[i] = undefined;
				 if (this._rowValues[i]) {
					 this._rowValues[i] = undefined;
				 }
			 }
		}
	}
}
function numOfModifiedCols() {
	if (this._targetedRow == -1) return 0;
	if (!this._rowValues) return 0;
	var mCount = 0;
	for (i=0; i<this._rowValues.length; i++) {
		 if (this._rowValues[i]) mCount++;
	}
	return mCount;	
}
function setInitialNumberColumns(nColumns) {
	if (!this._mySpreadSheet.rows(0)) {
		this._mySpreadSheet.cols = nColumns;
	}
}
function spreadSheetClick() {	
	this._selected_cell = event.srcElement;
	if (this._selected_cell.tagName != "TD") return;
	if (this._selected_cell.offsetWidth == "") {
	    this._selected_cell.offsetWidth=100;
	}           
    var selectedRow = this._selected_cell.parentElement.rowIndex; 
    if (selectedRow == 0) { return; } 
	if (this._targetedRow == -1) {
		this._targetedRow = selectedRow;
	} else if (this._targetedRow != selectedRow) {
		if (this.numOfModifiedCols() > 0) {
		    if (confirm("Currently, you can only update one row each time\n\nGive up changes in the previous row and update this row?")) {
	    	    this.restoreCellValue();
			    this._targetedRow = selectedRow;
	        } else {
	            return;
	        }
		} else {
			this._targetedRow = selectedRow;
	    }
	}
    this._row = selectedRow;
    this._col = this._selected_cell.cellIndex;        
    this._lastCellValue = this.retrieveCellValue(this._row, this._col);
	this._myEditCell.style.posLeft=calculate_absolute_X(event.srcElement); 
	this._myEditCell.style.posTop=calculate_absolute_Y(event.srcElement);
	this._myEditCell.style.posWidth=event.srcElement.offsetWidth;
	this._myEditCell.style.posHeight=event.srcElement.offsetHeight;	
	this._myEditCell.style.backgroundColor="#FFFF66";
	if (this._fontSize > 0) {
	    this._myEditCell.style.fontSize = this._fontSize;
	}
	this._myEditCell.style.fontFamily = this._fontFamily;
	this._myEditCell.style.display="";
	this._myEditCell.value = this._selected_cell.innerText;
	this._myEditCell.focus();
}
function handle_data() {
	if (this._myEditCell.value != "") {
		this._selected_cell.innerText = this._myEditCell.value;
	} else {
		this._selected_cell.innerHTML = "&nbsp;";
	}	
	this._myEditCell.style.display = "none";
    var currentValue = this.retrieveCellValue(this._row, this._col);
    if (currentValue == this._lastCellValue) {
        this._row = 0;
	    this._col = 0;
	    this._lastCellValue = 0;
    } else {
		this._rowValues[this._col] = currentValue;
		this._oldRowValues[this._col] = this._lastCellValue;
	}
	if ( (this._typeOfColumnFunction != null) && (this._typeOfColumnFunction != "") ) {
		this.applyColumnFunction();
	}
}
function setSpreadSheetResize(bResize, width) {
	this._internalSetSpreadSheetResize(bResize, width);
	this._internalSetCellFixedSize(false);
}
function _internalSetSpreadSheetResize(bResize, width) {
	if (bResize) {
		width = this.checkArgument(width);

		this._mySpreadSheet.width = (width + "%");
	} else {
		this._mySpreadSheet.width = "";
	}
}
function setCellFixedSize(bFixed, width) {
	this._internalSetCellFixedSize(bFixed, width);
	this._internalSetSpreadSheetResize(false);
}
function _internalSetCellFixedSize(bFixed, width) {
	if (bFixed) {
		width = checkArgument(width);
		this._mySpreadSheet.width = "";	
		this._myColGroup.width = width;
		this._mySpreadSheet.style.tableLayout = "fixed"; 
	} else {
		this._myColGroup.width = "";
		this._mySpreadSheet.style.tableLayout = "auto";
	}
}
function UpdateSpreadSheetColumns(newNumberColumns) {
	var iIndex;
	newNumberColumns = this.checkArgument(newNumberColumns, 0);
	var nCurrentNumberColumns = this._mySpreadSheet.cols;
	if (nCurrentNumberColumns == newNumberColumns) {
		return;
	}
	var currentRow;
	var oCOL;
	var nCurrentNumberRows = this._mySpreadSheet.rows.length;
	var j;
	if (nCurrentNumberColumns < newNumberColumns) {	
		var newCell;
		for (iIndex = 0; iIndex < nCurrentNumberRows; iIndex++) {
			currentRow = this._mySpreadSheet.rows(iIndex);		
			for (j = nCurrentNumberColumns; j < newNumberColumns; j++) {
				newCell = currentRow.insertCell();
				newCell.innerText = " ";
			}
		}		
		for (j = nCurrentNumberColumns; j < newNumberColumns; j++) {
			oCOL=document.createElement("COL");
			this._myColGroup.appendChild(oCOL);
		}
	} else {
		for (iIndex = 0; iIndex < nCurrentNumberRows; iIndex++) {
			currentRow = this._mySpreadSheet.rows(iIndex);	
			for (j = nCurrentNumberColumns; j > newNumberColumns; j--) {
				currentRow.deleteCell();
			}
		}
		for (j = nCurrentNumberColumns; j > newNumberColumns; j--) {
			oCOL=this._myColGroup.children(j-1);
			this._myColGroup.removeChild(oCOL);
		}

	}

	this._mySpreadSheet.cols = newNumberColumns;
}
function UpdateSpreadSheetRows(newNumberRows) {
	newNumberRows  = checkArgument(newNumberRows, 0);

	var nCurrentNumberRows = this._mySpreadSheet.rows.length;
	var nCurrentNumberColumns = this._mySpreadSheet.cols;
	var j;
	var iIndex;
	if (nCurrentNumberRows == newNumberRows) {
		return;
	}
	if (nCurrentNumberRows < newNumberRows) {
		var newRow;
		var newCell;

		for (iIndex = nCurrentNumberRows; iIndex < newNumberRows; iIndex++) {
			newRow = this._mySpreadSheet.insertRow();
			if (newRow != null) {
				for (j=0; j<nCurrentNumberColumns; j++) {
					newCell = newRow.insertCell();
					newCell.innerText = " ";
				}
			}
		}
	} else {
		for (iIndex = nCurrentNumberRows; iIndex > newNumberRows; iIndex--) {
			this._mySpreadSheet.deleteRow();
		}
	}
}
function checkArgument(inputArg, lowerBound) {
	if (isNaN(lowerBound)) {
		lowerBound = 1;
	}
	if (isNaN(inputArg)) {
		throw("'" + inputArg + "' is Not Numeric");
	} else {
		inputArg = parseFloat(inputArg);
		if (inputArg < lowerBound) {
			throw("'" + inputArg + "' is less than " + lowerBound);
		}
	}
	return inputArg;
}
function setClick(bSingle) {
	if (bSingle && (this._mySpreadSheet.ondblclick != null) )
	{
		this._click_callback = this._mySpreadSheet.ondblclick;
		this._mySpreadSheet.ondblclick=null;
		this._mySpreadSheet.onclick = this._click_callback;
	}
	else
	if ( this._mySpreadSheet.onclick != null )
	{
		this._click_callback = this._mySpreadSheet.onclick;
		this._mySpreadSheet.onclick=null;
		this._mySpreadSheet.ondblclick = this._click_callback;
	}
}
function handleSpreadSheetResize() {
	this._myEditCell.style.display = "none";
}
function handleWindowResize() {
	var iIndex;
	for (iIndex=0; iIndex < spreadSheetHandlesArray.length; iIndex++)
	{
		spreadSheetHandlesArray[iIndex].handleSpreadSheetResize();
	}
}
function applyColumnFunction() {
	var nCurrentNumberColumns = this._mySpreadSheet.cols;
	var nCurrentNumberRows = this._mySpreadSheet.rows.length - 1;
	var currentRowCells;
	var j;
	var iIndex;
	if (this._typeOfColumnFunction == "") {
		currentRowCells = this._mySpreadSheet.rows(nCurrentNumberRows).cells;
		for (j = 0; j < nCurrentNumberColumns; j++) {
			currentRowCells[j].innerHTML = "&nbsp;";
		}

		return;
	}
	if (nCurrentNumberRows == 0) {
		return;
	}
	var resultArray = new Array();
	for (j = 0; j < nCurrentNumberColumns; j++) {
		resultArray[j] = 0;
	}
	for (iIndex = 0; iIndex < nCurrentNumberRows; iIndex++) {
		currentRowCells = this._mySpreadSheet.rows(iIndex).cells;
		for (j = 0; j < nCurrentNumberColumns; j++) {
			resultArray[j] = resultArray[j] + 1*currentRowCells[j].innerText;
		}
	}
	if (this._typeOfColumnFunction == "average") {
		if (nCurrentNumberRows > 0) {
			for (j = 0; j < nCurrentNumberColumns; j++) {
				resultArray[j] = resultArray[j] / nCurrentNumberRows;
			}
		}
	}
	currentRowCells = this._mySpreadSheet.rows(nCurrentNumberRows).cells;
	for (j = 0; j < nCurrentNumberColumns; j++) {
		currentRowCells[j].innerText = resultArray[j];
	}
}
function setFunctionName(functionName) {
	var myFunction = functionName.toLowerCase();
	if ((myFunction != "") && (myFunction != "sum") && (myFunction != "average")) {
		throw("'" + functionName + "' is not a valid function name");
	}
	this._typeOfColumnFunction = myFunction;
	this.applyColumnFunction();
}
function getNumberRows() {
	return this._mySpreadSheet.rows.length;
}
function getNumberColumns() {
	return this._mySpreadSheet.cols;
}
function retrieveRowValues( rowNumber ) {
	var nCurrentNumberColumns = this.getNumberColumns();
	var nCurrentNumberRows = this.getNumberRows();
	if ((nCurrentNumberRows == 0) || (nCurrentNumberColumns == 0)) {
		throw ("The spread sheet has no data." );
	}
	rowNumber = checkArgument( rowNumber, 0 );
	if ( rowNumber >= nCurrentNumberRows ) {
		throw ("Valid row numbers are 0 to " + (nCurrentNumberRows - 1) );
	}
	var rowArray = new Array();
	var j;
	var currentRowCells = this._mySpreadSheet.rows(rowNumber).cells;
	for (j = 0; j < nCurrentNumberColumns; j++) {
		rowArray[rowArray.length] = currentRowCells[j].innerText;
	}
	return rowArray;
}
function retrieveColumnValues( columnNumber ) {
	var nCurrentNumberColumns = this.getNumberColumns();
	var nCurrentNumberRows = this.getNumberRows();
	if ((nCurrentNumberRows == 0) || (nCurrentNumberColumns == 0)) {
		throw ("The spread sheet has no data." );
	}
	columnNumber = checkArgument( columnNumber, 0 );
	if ( columnNumber >= nCurrentNumberColumns ) {
		throw ("Valid column numbers are 0 to " + (nCurrentNumberColumns - 1) );
	}
	var columnArray = new Array();
	var iIndex;
	var currentRowCells;
	for (iIndex = 0; iIndex < nCurrentNumberRows; iIndex++) {
		currentRowCells = this._mySpreadSheet.rows(iIndex).cells;
		columnArray[columnArray.length] = currentRowCells[columnNumber].innerText;
	}
	return columnArray;
}
function retrieveCellValue( rowNumber, columnNumber ) {
	var nCurrentNumberColumns = this.getNumberColumns();
	var nCurrentNumberRows = this.getNumberRows();
	if ((nCurrentNumberRows == 0) || (nCurrentNumberColumns == 0)) {
		throw ("The spread sheet has no data." );
	}
	rowNumber = checkArgument( rowNumber, 0 ); 
	columnNumber = checkArgument( columnNumber, 0 );
	if ( columnNumber >= nCurrentNumberColumns ) {
		throw ("Valid column numbers are 0 to " + (nCurrentNumberColumns - 1) );
	}
	var rowArray = this.retrieveRowValues( rowNumber );
	return rowArray[columnNumber];
}
function setCellValue( rowNumber, columnNumber, strValue ) {
	var nCurrentNumberColumns = this.getNumberColumns();
	var nCurrentNumberRows = this.getNumberRows();
	if ((nCurrentNumberRows == 0) || (nCurrentNumberColumns == 0)) {
		throw ("The spread sheet has no columns or rows." );
	}
	rowNumber = checkArgument( rowNumber, 0 ); 
	if ( rowNumber >= nCurrentNumberRows ) {
		throw ("Valid row numbers are 0 to " + (nCurrentNumberRows - 1) );
	}
	columnNumber = checkArgument( columnNumber, 0 );
	if ( columnNumber >= nCurrentNumberColumns ) {
		throw ("Valid column numbers are 0 to " + (nCurrentNumberColumns - 1) );
	}
	var currentRowCells = this._mySpreadSheet.rows( rowNumber ).cells;	
	if ( strValue != "") {
		currentRowCells[columnNumber].innerText = strValue;
	} else {
		currentRowCells[columnNumber].innerHTML = "&nbsp;";
	}
	if ( (this._typeOfColumnFunction != null) && (this._typeOfColumnFunction != "") ) {
		this.applyColumnFunction();
	}
}
