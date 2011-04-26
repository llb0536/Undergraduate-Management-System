// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function checkall(form, prefix) {
	for(var i = 0; i < form.elements.length; i++) {
		var e = form.elements[i];
		if(e.name != 'chkall' && (!prefix || (prefix && e.name.match(prefix)))) {
			e.checked = form.chkall.checked;
		}
	}
}
function checknotnil_inner(form){
	for(var i=0;i<form.elements.length;i++){
		var e=form.elements[i];
		if(e.checked){return true;}
	}
	return false;
}