/**
* $HeadURL$ 
* $Date$
* $Author$
* $Revision$
*
* Vinter.validate()
* Version 1.9.5
*
* Vinter.validate is (c) 2008 Lars Huring, Olov Nilzén and Vinter (www.vinterwebb.se) and is released under the MIT License:
* http://www.opensource.org/licenses/mit-license.php
* 
* Changelog:
* 1.1:
* - Added checkbox validation
* - Added checkbox groups validation
* - Added isNumber validation
* - Added onerror callback handler
*
* 1.2:
* - Added selectbox validation
* - Added file-validation
*
* 1.3
* - Added radiobutton validation
* - Added textarea validation
*
* 1.4
* - Added possibility to send html in errmsg
* - Fixed removal of notvalidclass on each validation.
*
* 1.5
* - Added possibility to check against default value (title attribute).
* - Added id to error li:s for possibity to hide em'
* - Updated the examples and added a little more documentation
*
* 1.6
* - Added selectbox default values array
* - Added "defaultval" class to <option>, config: selectboxdefaultclass
* - Added selectbox validation to example
*
* 1.7
* - Added source to SVN repository
* - Changed filenames to exclude version numbers
* - Updated jQuery-version to 1.2.6
*
* 1.8
* Added by Mehdi Cherifi (superyms)
* - Added DATE format (Matches the following formats mm/dd/yy, mm/dd/yyyy, mm-dd-yy, mm-dd-yyyy This covers days with 30 or 31 days but does not handle February, it is allowed 30 days.)
* - Added time format validation
* - Added Url validation
*
* Added by Pitt Phunsanit
* - Added float-number validation 
*
* 1.8.1
* - Changed isNumber to include whitespace as valid character
*
* 1.9
* - Wrapped error messages in <label for="input_id"></label>, now they can be clicked and re-focus input to the error field. Cheers @twitter.com/icaaq for idea.
* - Added errorlabelclass option for error message label to enable better styling (see cursor in demo)
* - Changed $ to jQuery to avoid conflicts
*
* 1.9.1
* - Added oncomplete event
*
* 1.9.5
* - Updated default options to a more jQuery-default syntax.
* - Added configuration possibility for required, checkboxgroup and radiogroup classes.
* - Added configuration possibility for required, checkboxgroup and radiogroup patterns.
* - Added override possibilities for all validation methods
*
* Usage:
* Simple: <input type="submit" value="skicka" onclick="return jQuery.validate();" />
* Advanced: http://labs.vinterwebb.se/jquery.validate/Default.aspx
*
*/
(function(jQuery) {

	jQuery.validate = function(opt)
	{
		
		/**
		* Default options
		*/	
		var options = jQuery.extend({
			fieldset: "",
			messagecontainer: "#validationmsg",
			errormsg: ".errmsg",
			notvalidclass: "notvalid",
			messageheader: "Hittade några problem i formuläret",
			onerror: "",
			oncomplete: "",
			erroridprefix: "validationerror_",
			selectboxdefault: [""],
			selectboxdefaultclass: "defaultval",
			usedefault: false,
			errorlabelclass: "errormsglabel",
			requiredclass: "required",
			radiogroupclass: "radiogroup",
			checkboxgroupclass: "checkboxgroupclass",
			isEmail: isEmail,
			isNumber: isNumber,
			isEmpty: isEmpty,
			isUrl: isUrl,
			isDate: isDate,
			isTime: isTime,
			isFloat: isFloat
		}, opt);
		
		options = jQuery.extend({
			requiredpattern: options.fieldset + " ." + options.requiredclass,
			radiogrouppattern: options.fieldset + " ." + options.radiogroupclass,
			checkboxgrouppattern: options.fieldset + " ." + options.checkboxgroupclass
		}, options);
				
	    var errors = new Array();
		jQuery(options.messagecontainer).empty();
		
		jQuery("." + options.notvalidclass).each(function(i, item) {
			jQuery(item).removeClass(options.notvalidclass);
		});
		
		function isEmail(str) 
	    {
		    var regex = /^[a-zA-Z0-9._-]+@([a-zA-Z0-9.-]+\.)+[a-zA-Z0-9.-]{2,4}$/;
		    return regex.test(str);
	    }
	    
	    function isNumber(str) 
	    {
		    var regex = /^[0-9-\s]*$/;
		    return regex.test(str);
	    }
	    
	    function isEmpty(item) 
	    {
		    if (item.value == "")
		        return true;

            if (options.usedefault && item.value == jQuery(item).attr("title"))
                return true;

            return false;
	    }
		
		function isUrl(str)
	    {
		    var regex = /^((http|ftp|https):\/\/w{3}[\d]*.|(http|ftp|https):\/\/|w{3}[\d]*.)([\w\d\._\-#\(\)\[\]\\,;:]+@[\w\d\._\-#\(\)\[\]\\,;:])?([a-z0-9]+.)*[a-z\-0-9]+.([a-z]{2,3})?[a-z]{2,6}(:[0-9]+)?(\/[\/a-z0-9\._\-,]+)*[a-z0-9\-_\.\s\%]+(\?[a-z0-9=%&amp;\.\-,#]+)?$/;
		    return regex.test(str);
	    }
		
		function isDate(str)
	    {
		    var regex = /^((0?[13578]|10|12)(-|\/)((0[0-9])|([12])([0-9]?)|(3[01]?))(-|\/)((\d{4})|(\d{2}))|(0?[2469]|11)(-|\/)((0[0-9])|([12])([0-9]?)|(3[0]?))(-|\/)((\d{4}|\d{2})))$/;
		    return regex.test(str);
	    }
		
		function isTime(str)
	    {
		    var regex = /^(([0-1]?[0-9])|([2][0-3])):([0-5]?[0-9])(:([0-5]?[0-9]))?$/;
		    return regex.test(str);
	    }
		
		function isFloat(str) 
	    {
		    var regex = /^([+-]?(((\d+(\.)?)|(\d*\.\d+))([eE][+-]?\d+)?))$/;
		    return regex.test(str);
	    }
		
		function getMsg(item)
		{
			return jQuery(item.parentNode).find(options.errormsg).html();
		}
		
		function validateTextBox(item)
		{
			if (options.isEmpty(item) == true || (jQuery(item).hasClass("email") && options.isEmail(item.value) == false))
				errors.push({id: item.id, msg: getMsg(item), type: "text"});
			
			if (options.isEmpty(item) == false && (jQuery(item).hasClass("date") && options.isDate(item.value) == false))
				errors.push({id: item.id, msg: getMsg(item), type: "text"});
				
			if (options.isEmpty(item) == false && (jQuery(item).hasClass("time") && options.isTime(item.value) == false))
				errors.push({id: item.id, msg: getMsg(item), type: "text"});
				
			if (options.isEmpty(item) == false && jQuery(item).hasClass("float") && options.isFloat(item.value) == false)
				errors.push({id: item.id, msg: getMsg(item), type: "float"});
			
			if (options.isEmpty(item) == false && (jQuery(item).hasClass("url") && options.isUrl(item.value) == false))
				errors.push({id: item.id, msg: getMsg(item), type: "text"});
			
			if (options.isEmpty(item) == false && jQuery(item).hasClass("number") && options.isNumber(item.value) == false)
				errors.push({id: item.id, msg: getMsg(item), type: "number"});
		}
		
		function validateCheckbox(item)
		{
			if(item.checked != true)
				errors.push({id: item.id, msg: getMsg(item), type: "checkbox"});
		}
		
		function validateSelect(item)
		{	
			if (jQuery.inArray(item.value, options.selectboxdefault) > -1 || item[item.selectedIndex].className == options.selectboxdefaultclass)
				errors.push({id: item.id, msg: getMsg(item), type: "select-one"});
		}
		
		// Loop
		jQuery(options.requiredpattern).each(function(i, item) {

			// Checkboxes
			switch (item.type)
			{
				case "checkbox":
					validateCheckbox(item);
					break;
					
				case "text":
				case "file":
				case "textarea":
				case "hidden":
				case "password":
					validateTextBox(item);
					break;
				
				case "select-one":
					validateSelect(item);
			}
			
		});
		
		/*
		* Validate checkbox groups
		*/
		jQuery(options.checkboxgrouppattern + "," + options.radiogrouppattern).each(function(i, item) {
			
			var checked = 0;
			var msg = jQuery(item).find(options.errormsg).text();
			
			jQuery(item).find("input[type=checkbox], input[type=radio]").each(function(i, item) {
				if (item.checked)
					checked++;
			});
			
			if(checked == 0)
				errors.push({id: item.id, msg: msg, type: "group"});
			
		});
		
		/*
		* Check errors length and output to page.
		*/	
		if (errors.length > 0)
		{
			
			// Onerror returns errors array to callback
			if (typeof(options.onerror) == "function")
			{
				options.onerror(errors);
				return false;
			}

			jQuery(options.messagecontainer).fadeIn("slow");
			
			jQuery("<h4/>")
				.text(options.messageheader)
				.appendTo(jQuery(options.messagecontainer));
			
			var ul = jQuery("<ul/>");
			
			jQuery(errors).each(function(i, item) {
				
				jQuery("#" + item.id).addClass(options.notvalidclass);
				
				jQuery("<li />")
					.attr("id", options.erroridprefix + item.id)
					.append("<label for='" + item.id + "' class='" + options.errorlabelclass + "'>" + item.msg + "</label>")
					.appendTo(ul);
			});
			
			ul.appendTo(jQuery(options.messagecontainer));
			
			return false;
		}			
		
		if (typeof(options.oncomplete) == "function")
			options.oncomplete();
		
		// Hide if there are no errors
		jQuery(options.messagecontainer).fadeOut();
		return true;
	
	}

})(jQuery);