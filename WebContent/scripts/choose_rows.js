function chooseMaxRows(divId, topOffSet, leftOffSet) {
    var divObject = document.getElementById(divId);
	divObject.style.top = topOffSet;
	divObject.style.left = mx - (leftOffSet);
	divObject.style.display = 'block';
}