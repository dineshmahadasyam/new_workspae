package com.dell.diamond.util


import java.text.SimpleDateFormat
import org.springframework.web.servlet.support.RequestContextUtils as RCU

class FmsUiTagLib {
	static namespace = "fmsui"
	SimpleDateFormat dateParser = new java.text.SimpleDateFormat("MM/dd/yyyy")
	
	

	def datePicker = { attrs , body ->
		def dateElementId = attrs.dateElementId
		def dateElementName = attrs.dateElementName
		def dateElementValue = attrs.dateElementValue
		def additionalDateProperties = attrs.dateJSUIProperties
		//println "in taglib with elementid = " + dateElementId + "element name = "+ dateElementName
		if(dateElementId && dateElementName) {
			//println ("dateElementId = " + dateElementId)
			if(dateElementId.indexOf(".") != -1) {
				dateElementId = dateElementId.replace('.', '_')
			}
			//println ("dateElementId = " + dateElementId)
			String htmlString = new String()
			def javascriptFnHTML = "<script>\n\$(function() {\$(\"#${dateElementId}\").datepicker({${(additionalDateProperties ? additionalDateProperties : "")}});});\n</script>\n\n"
			htmlString = htmlString.concat (javascriptFnHTML)
			def dateHTML = "<input type=\"text\"  id=\"${dateElementId}\" name=\"${dateElementName }\" value=${dateElementValue?dateElementValue :"" }>\n"
			htmlString = htmlString.concat (dateHTML)
			//println "html String returned = " + htmlString
			out << (htmlString)
		} else{
			out << body()
		}
	}

	def jqDatePicker = {attrs, body ->
		def out = out
		def dateElementName = attrs.dateElementName    //The name attribute is required for the tag to work seamlessly with grails
		def dateElementId = attrs.dateElementId
		def dateElementValue= attrs.dateElementValue
		def mandatory = attrs.mandatory
		def disabled = attrs.disabled
		def readOnly = attrs.readOnly
		def autofocus = attrs.autofocus
		def autocomplete = attrs.autocomplete
		def ariaAttributes = attrs.ariaAttributes
		def classAttributes = attrs.classAttributes
		
		def datePickerOptions = attrs.datePickerOptions 
		
		def lastDayOnly = attrs.lastDayOnly
		def title = attrs.title
		def dateString =""
		def dayString  =""
		def monthString =""
		def yearString =""
		
		
		if(dateElementValue) {
			Date inputDate  = dateParser.parse(dateElementValue)
			dateString = dateElementValue
			GregorianCalendar gc = new GregorianCalendar()
			gc.setTime(inputDate)
			
			dayString = gc.get(Calendar.DAY_OF_MONTH) 
			monthString = (gc.get(Calendar.MONTH)) +1 
			yearString =  gc.get(Calendar.YEAR) 
		}
		def minDate = attrs.minDate
		def maxDate = attrs.maxDate
		def showDay = attrs.showDay
		
		//out.println "<script>\n\$(function() {\$(\"#${id}\").datepicker({${(additionalDateProperties ? additionalDateProperties : "")}});});\n</script>\n\n"
		//Create date text field and supporting hidden text fields need by grails
		if(!readOnly) {

			if (!mandatory) 
			{
				out.println "<input type=\"text\" readonly=\"true\" class=\"onDelete\" name=\"${dateElementName}\" id=\"${dateElementId}\" value=\"${dateElementValue ? dateElementValue : ''}\" maxlength=\"10\" "
			}
			else
			{
				out.println "<input type=\"text\" readonly=\"true\" class=\"onDeleteMandatory\" name=\"${dateElementName}\" id=\"${dateElementId}\" value=\"${dateElementValue ? dateElementValue : ''}\" maxlength=\"10\" "
			}			
			if(ariaAttributes) {
				out.println " ${ariaAttributes}"
			}
			if(classAttributes) {
				out.println " ${classAttributes}"
			}
			if(autofocus) {
				out.println "autofocus=\"autofocus\""
			}
			if(autocomplete) {
				out.println "autoComplete=\"${autocomplete}\""
			}
			if (title) {
				out.println "title=\"${title}\""
			}
			if(disabled == "true") {
				out.println "disabled=\"disabled\""
			}
			out.println"/>"

		} else {
			out.println "<input type=\"hidden\" name=\"${dateElementName}\" id=\"${dateElementId}\" value=\"${dateElementValue}\"/>"
			out.println dateElementValue
		}
		out.println "<input type=\"hidden\" name=\"${dateElementName}_day\" id=\"${dateElementName}_day\"  value=\"${dayString}\" />"
		out.println "<input type=\"hidden\" name=\"${dateElementName}_month\" id=\"${dateElementName}_month\" value=\"${monthString}\"/>"
		out.println "<input type=\"hidden\" name=\"${dateElementName}_year\" id=\"${dateElementName}_year\" value=\"${yearString}\" />"

		//Code to parse selected date into hidden fields required by grails
		out.println "<script type=\"text/javascript\"> \$(document).ready(function(){"
		out.println "\$(jq(\"${dateElementId}\")).datepicker({"
		//additionalDateProperties? additionalDateProperties+", " :""
		
		//Code for  validation error message for the datepicker to disappear immediately a date is selected. Needs to be validated only when there is date
		//Trigger code added which can be used to check when user clicks on close without saving date
		out.println "onSelect: function() {"
		out.println "if(\$(this).datepicker('getDate') !== null) {"
		out.println	"\$(this).valid();"
		out.println	"}"
		out.println "\$(this).trigger('dateupdated');"
		out.println	"},"
		
		
		out.println "onClose: function(dateText, inst) {"
		out.println "\$(jq(\"${dateElementId}_month\")).attr(\"value\",new Date(dateText).getMonth() +1);"
		out.println "\$(jq(\"${dateElementId}_day\")).attr(\"value\",new Date(dateText).getDate());"
		out.println "\$(jq(\"${dateElementId}_year\")).attr(\"value\",new Date(dateText).getFullYear());"
		out.println "}"

		//If you want to customize using the jQuery UI events add an if block an attribute as follows
		if(minDate != null){
			out.println ","
			out.println "minDate: ${minDate}"
		}
		if(maxDate != null){
			out.println ","
			out.println "maxDate: ${maxDate}"
		}
		if(datePickerOptions != null) {
			out.println ","
			out.println "$datePickerOptions"
			
		}		
		if(lastDayOnly != null){
			out.println ","
			out.println "beforeShowDay: function(date){"
			
			out.println "if (date.getDate() ==	getLastDayOfYearAndMonth(date.getFullYear(), date.getMonth()))"
			out.println "{ "
				out.println "return [true, ''];"
			out.println "}"

			out.println "return [false, ''];"
			//out.println	"var day = date.getDay();"
			//out.println	"return [day == ${showDay},\"\"];"
			out.println "}"
		}
		
		if(showDay != null) {
			out.println ","
			out.println "beforeShowDay: function(date){"
			out.println	"var day = date.getDay();"
			out.println	"return [day == ${showDay},\"\"];"
			out.println "}"

		}

		out.println "});"
		
		//Date fields are set as read only. This piece of code will allow the user to still delete (using backspace and delete buttons) 
		//preventDefault is used so it does not post back to previous page when backspace button is used
		//this.focus so the calendar would open automatically when there is a validation error on that field
		out.println "\$('.onDeleteMandatory').bind('keypress keydown keyup', function(e) {"
		out.println "if ( e.keyCode == 8 || e.keyCode == 46){"
		out.println "\$.datepicker._clearDate(this);"
		out.println "\$(this).focus();"
		out.println "e.preventDefault();"
		out.println "}});"
		
		//Date fields are set as read only. This piece of code will allow the user to still delete (using backspace and delete buttons)
		//preventDefault is used so it does not post back to previous page when backspace button is used
		out.println "\$('.onDelete').bind('keypress keydown keyup', function(e) {"
		out.println "if ( e.keyCode == 8 || e.keyCode == 46){"
		out.println "\$.datepicker._clearDate(this);"
		out.println "e.preventDefault();"
		out.println "}});"

		out.println "})</script>"

	}
	
	/**
	 * This codes is copied from jqDatePicker and added few UIUX classes
	 */
	def jqDatePickerUIUX = {attrs, body ->
		def out = out
		def dateElementName = attrs.dateElementName    //The name attribute is required for the tag to work seamlessly with grails
		def dateElementId = attrs.dateElementId
		def dateElementValue= attrs.dateElementValue
		def mandatory = attrs.mandatory
		def disabled = attrs.disabled
		def readOnly = attrs.readOnly ? Boolean.valueOf(attrs.readOnly) : false
		def autofocus = attrs.autofocus
		def autocomplete = attrs.autocomplete
		def ariaAttributes = attrs.ariaAttributes
		def classAttributes = attrs.classAttributes
		
		def datePickerOptions = attrs.datePickerOptions
		
		def lastDayOnly = attrs.lastDayOnly
		def title = attrs.title
		def dateString =""
		def dayString  =""
		def monthString =""
		def yearString =""
		def showIconDefault = attrs.showIconDefault ? Boolean.valueOf(attrs.showIconDefault) : false
		def calendarButtonId = "_calendar_button_${dateElementId}"
				
				
		if(dateElementValue) {
			Date inputDate  = dateParser.parse(dateElementValue)
			dateString = dateElementValue
			GregorianCalendar gc = new GregorianCalendar()
			gc.setTime(inputDate)
			
			dayString = gc.get(Calendar.DAY_OF_MONTH)
			monthString = (gc.get(Calendar.MONTH)) +1
			yearString =  gc.get(Calendar.YEAR)
		}
		def minDate = attrs.minDate
		def maxDate = attrs.maxDate
		def showDay = attrs.showDay
		
		//out.println "<script>\n\$(function() {\$(\"#${id}\").datepicker({${(additionalDateProperties ? additionalDateProperties : "")}});});\n</script>\n\n"
		//Create date text field and supporting hidden text fields need by grails
		if(!readOnly) {
				
			if (!mandatory) {
				out.println "<input type=\"text\"  class=\"onDelete form-control fms_date_mask fms_small_input DatePicker\" name=\"${dateElementName}\" id=\"${dateElementId}\" value=\"${dateElementValue ? dateElementValue : ''}\" maxlength=\"10\" "
			} else {
				out.println "<input type=\"text\" class=\"onDeleteMandatory form-control fms_date_mask fms_small_input DatePicker\" name=\"${dateElementName}\" id=\"${dateElementId}\" value=\"${dateElementValue ? dateElementValue : ''}\" maxlength=\"10\" "
			}
			
			if(ariaAttributes) {
				out.println " ${ariaAttributes}"
			}
			if(classAttributes) {
				out.println " ${classAttributes}"
			}
			if(autofocus) {
				out.println "autofocus=\"autofocus\""
			}
			if(autocomplete) {
				out.println "autoComplete=\"${autocomplete}\""
			}
			if (title) {
				out.println "title=\"${title}\""
			}
			if(disabled == "true") {
				out.println "disabled=\"disabled\""
			}
			out.println"/>"

		} else {
			out.println "<input type=\"hidden\" name=\"${dateElementName}\" id=\"${dateElementId}\" value=\"${dateElementValue}\"/>"
			out.println dateElementValue
		}
		out.println "<input type=\"hidden\" name=\"${dateElementName}_day\" id=\"${dateElementName}_day\"  value=\"${dayString}\" />"
		out.println "<input type=\"hidden\" name=\"${dateElementName}_month\" id=\"${dateElementName}_month\" value=\"${monthString}\"/>"
		out.println "<input type=\"hidden\" name=\"${dateElementName}_year\" id=\"${dateElementName}_year\" value=\"${yearString}\" />"

		//Code to parse selected date into hidden fields required by grails
		out.println "<script type=\"text/javascript\"> \$(document).ready(function(){"
		out.println "\$(jq(\"${dateElementId}\")).datepicker({"
		//additionalDateProperties? additionalDateProperties+", " :""
		
		//Code for  validation error message for the datepicker to disappear immediately a date is selected. Needs to be validated only when there is date
		//Trigger code added which can be used to check when user clicks on close without saving date
		out.println "onSelect: function() {"
		out.println "if( (\$(this).datepicker('getDate') !== null) && (isInvalidForm == 'true')) {"
		out.println	"\$(this).valid();"
		out.println	"}"
		out.println "\$(this).trigger('dateupdated');"
		out.println	"},"
		
		
		out.println "onClose: function(dateText, inst) {"
		out.println "\$(jq(\"${dateElementId}_month\")).attr(\"value\",new Date(dateText).getMonth() +1);"
		out.println "\$(jq(\"${dateElementId}_day\")).attr(\"value\",new Date(dateText).getDate());"
		out.println "\$(jq(\"${dateElementId}_year\")).attr(\"value\",new Date(dateText).getFullYear());"
		out.println "\$(this).parents().nextAll().find(\$(\":input[type !='hidden']\")).first().focus();"
		//out.println "event.preventDefault();"
		out.println "}"

		//If you want to customize using the jQuery UI events add an if block an attribute as follows
		if(minDate != null){
			out.println ","
			out.println "minDate: ${minDate}"
		}
		if(maxDate != null){
			out.println ","
			out.println "maxDate: ${maxDate}"
		}
		if(datePickerOptions != null) {
			out.println ","
			out.println "$datePickerOptions"
			
		}
		
		out.println ","
		out.println "showOn: \"button\","
		out.println"calendarButtonId: \"${calendarButtonId}\","
		out.println "buttonText: \"<i class='fa fa-calendar'></i>\""	
		
		if(lastDayOnly != null){
			out.println ","
			out.println "beforeShowDay: function(date){"
			
			out.println "if (date.getDate() ==	getLastDayOfYearAndMonth(date.getFullYear(), date.getMonth()))"
			out.println "{ "
				out.println "return [true, ''];"
			out.println "}"

			out.println "return [false, ''];"
			//out.println	"var day = date.getDay();"
			//out.println	"return [day == ${showDay},\"\"];"
			out.println "}"
		}
		
		if(showDay != null) {
			out.println ","
			out.println "beforeShowDay: function(date){"
			out.println	"var day = date.getDay();"
			out.println	"return [day == ${showDay},\"\"];"
			out.println "}"

		}

		//out.println "}).inputmask('mm/dd/yyyy', {yearrange: { minyear: 1900, maxyear: 2000 }});"
		out.println "}).inputmask('mm/dd/yyyy');"
		
		out.println "\$(jq(\"${dateElementId}\")).focusout(function() {"
			out.println "var dateText=\$(jq(\"${dateElementId}\")).val();"
			out.println("var dateValue = new Date(dateText)")
			out.println("if (!(isNaN(parseFloat(dateValue.getMonth())))) {")
			out.println "	\$(jq(\"${dateElementId}_month\")).attr(\"value\",dateValue.getMonth() +1);"
			out.println "	\$(jq(\"${dateElementId}_day\")).attr(\"value\",dateValue.getDate());"
			out.println "	\$(jq(\"${dateElementId}_year\")).attr(\"value\",dateValue.getFullYear());"
			out.println("} else {")
			out.println("\$(jq(\"${dateElementId}\")).val(\"\")")
			out.println "	\$(jq(\"${dateElementId}_month\")).attr(\"value\",\"\");"
			out.println "	\$(jq(\"${dateElementId}_day\")).attr(\"value\",\"\");"
			out.println "	\$(jq(\"${dateElementId}_year\")).attr(\"value\",\"\");"
			out.println("}")
		out.println "});"
		//Date fields are set as read only. This piece of code will allow the user to still delete (using backspace and delete buttons)
		//preventDefault is used so it does not post back to previous page when backspace button is used
		//this.focus so the calendar would open automatically when there is a validation error on that field
		out.println "\$('.onDeleteMandatory').bind('keypress keydown keyup', function(e) {"
		out.println "if ( e.keyCode == 8 || e.keyCode == 46){"
		out.println "\$.datepicker._clearDate(this);"
		out.println "\$(this).focus();"
		out.println "e.preventDefault();"
		out.println "}});"
		
		//Date fields are set as read only. This piece of code will allow the user to still delete (using backspace and delete buttons)
		//preventDefault is used so it does not post back to previous page when backspace button is used
		out.println "\$('.onDelete').bind('keypress keydown keyup', function(e) {"
		out.println "if ( e.keyCode == 8 || e.keyCode == 46){"
		out.println "\$.datepicker._clearDate(this);"
		out.println "e.preventDefault();"
		out.println "}});"
		if(!showIconDefault) {
			out.println "\$(jq(\"${calendarButtonId}\")).hide()";
		} else {
			out.println "\$(jq(\"${calendarButtonId}\")).show()";
		}
		out.println "})"

		out.println "</script>";

	}
	
	/**
	 * This codes is copied from jqDatePicker and added few UIUX classes
	 */
	def jqDatePickerNoDayUIUX = {attrs, body ->
		def out = out
		def dateElementName = attrs.dateElementName    //The name attribute is required for the tag to work seamlessly with grails
		def dateElementId = attrs.dateElementId
		def dateElementValue= attrs.dateElementValue
		def mandatory = attrs.mandatory
		def disabled = attrs.disabled
		def readOnly = attrs.readOnly ? Boolean.valueOf(attrs.readOnly) : false
		def autofocus = attrs.autofocus
		def autocomplete = attrs.autocomplete
		def ariaAttributes = attrs.ariaAttributes
		def classAttributes = attrs.classAttributes
		
		def datePickerOptions = attrs.datePickerOptions
		
		def lastDayOnly = attrs.lastDayOnly
		def title = attrs.title
		def dateString =""
		def dayString  =""
		def monthString =""
		def yearString =""
		def showIconDefault = attrs.showIconDefault ? Boolean.valueOf(attrs.showIconDefault) : false
		def calendarButtonId = "_calendar_button_${dateElementId}"
		
		
		if(dateElementValue) {
			SimpleDateFormat dateParserNoDay = new java.text.SimpleDateFormat("MM/yyyy");
			Date inputDate  = dateParserNoDay.parse(dateElementValue);
			dateString = dateElementValue;
			GregorianCalendar gc = new GregorianCalendar();
			gc.setTime(inputDate)
			
			dayString = gc.get(Calendar.DAY_OF_MONTH)
			monthString = (gc.get(Calendar.MONTH)) +1
			yearString =  gc.get(Calendar.YEAR)
		}
		def minDate = attrs.minDate
		def maxDate = attrs.maxDate
		def showDay = attrs.showDay
		
		//out.println "<script>\n\$(function() {\$(\"#${id}\").datepicker({${(additionalDateProperties ? additionalDateProperties : "")}});});\n</script>\n\n"
		//Create date text field and supporting hidden text fields need by grails
		if(!readOnly) {
				
			if (!mandatory) {
				out.println "<input type=\"text\"  class=\"onDelete form-control fms_date_masknoday fms_small_input DatePicker\" name=\"${dateElementName}\" id=\"${dateElementId}\" value=\"${dateElementValue ? dateElementValue : ''}\" maxlength=\"10\" "
			} else {
				out.println "<input type=\"text\" class=\"onDeleteMandatory form-control fms_date_masknoday fms_small_input DatePicker\" name=\"${dateElementName}\" id=\"${dateElementId}\" value=\"${dateElementValue ? dateElementValue : ''}\" maxlength=\"10\" "
			}
			
			if(ariaAttributes) {
				out.println " ${ariaAttributes}"
			}
			if(classAttributes) {
				out.println " ${classAttributes}"
			}
			if(autofocus) {
				out.println "autofocus=\"autofocus\""
			}
			if(autocomplete) {
				out.println "autoComplete=\"${autocomplete}\""
			}
			if (title) {
				out.println "title=\"${title}\""
			}
			if(disabled == "true") {
				out.println "disabled=\"disabled\""
			}
			out.println"/>"

		} else {
			out.println "<input type=\"hidden\" name=\"${dateElementName}\" id=\"${dateElementId}\" value=\"${dateElementValue}\"/>"
			out.println dateElementValue
		}
		out.println "<input type=\"hidden\" name=\"${dateElementName}_day\" id=\"${dateElementName}_day\"  value=\"${dayString}\" />"
		out.println "<input type=\"hidden\" name=\"${dateElementName}_month\" id=\"${dateElementName}_month\" value=\"${monthString}\"/>"
		out.println "<input type=\"hidden\" name=\"${dateElementName}_year\" id=\"${dateElementName}_year\" value=\"${yearString}\" />"

		out.println "<style>.ui-datepicker-calendar {display: none;}</style>"
		
		//Code to parse selected date into hidden fields required by grails
		out.println "<script type=\"text/javascript\"> \$(document).ready(function(){"
		out.println "\$(jq(\"${dateElementId}\")).datepicker({"
		//additionalDateProperties? additionalDateProperties+", " :""
		
		//Code for  validation error message for the datepicker to disappear immediately a date is selected. Needs to be validated only when there is date
		//Trigger code added which can be used to check when user clicks on close without saving date
		out.println "onSelect: function() {"
		out.println "if( (\$(this).datepicker('getDate') !== null) && (isInvalidForm == 'true')) {"
		out.println	"\$(this).valid();"
		out.println	"}"
		out.println "\$(this).trigger('dateupdated');"
		out.println	"},"
		
		
		out.println "onClose: function(dateText, inst) {"
		out.println "var month = \$(\"#ui-datepicker-div .ui-datepicker-month :selected\").val();"
		out.println "var year = \$(\"#ui-datepicker-div .ui-datepicker-year :selected\").val();"
		out.println "var dateValue = new Date(year, month, 1);"
		out.println "\$(this).datepicker('setDate', dateValue);"
		
		out.println "\$(jq(\"${dateElementId}_month\")).attr(\"value\",dateValue.getMonth() +1);"
		out.println "\$(jq(\"${dateElementId}_day\")).attr(\"value\",dateValue.getDate());"
		out.println "\$(jq(\"${dateElementId}_year\")).attr(\"value\",dateValue.getFullYear());"
		out.println "\$(this).parents().nextAll().find(\$(\":input[type !='hidden']\")).first().focus();"
		//out.println "event.preventDefault();"
		out.println "}"

		//If you want to customize using the jQuery UI events add an if block an attribute as follows
		if(minDate != null){
			out.println ","
			out.println "minDate: ${minDate}"
		}
		if(maxDate != null){
			out.println ","
			out.println "maxDate: ${maxDate}"
		}
		if(datePickerOptions != null) {
			out.println ","
			out.println "$datePickerOptions"
			
		}
		
		out.println ","
		out.println "dateFormat: \"mm/yy\""
		
		
		out.println ","
		out.println "showOn: \"button\","
		out.println"calendarButtonId: \"${calendarButtonId}\","
		out.println "buttonText: \"<i class='fa fa-calendar'></i>\""
		
		out.println ","
		out.println "beforeShow : function(input, inst) {"
		out.println "var datestr;"
		out.println "if ((datestr = \$(this).val()).length > 0) {"
			out.println "year = datestr.substring(datestr.length-4, datestr.length);"
			out.println "month = datestr.substring(0, 2)"
			out.println "\$(this).datepicker('option', 'defaultDate', new Date(year, month-1, 1));"
			out.println "\$(this).datepicker('setDate', new Date(year, month-1, 1));"
			out.println "}"
		out.println "}"
		
		if(lastDayOnly != null){
			out.println ","
			out.println "beforeShowDay: function(date){"
			
			out.println "if (date.getDate() ==	getLastDayOfYearAndMonth(date.getFullYear(), date.getMonth()))"
			out.println "{ "
				out.println "return [true, ''];"
			out.println "}"

			out.println "return [false, ''];"
			//out.println	"var day = date.getDay();"
			//out.println	"return [day == ${showDay},\"\"];"
			out.println "}"
		}
		
		if(showDay != null) {
			out.println ","
			out.println "beforeShowDay: function(date){"
			out.println	"var day = date.getDay();"
			out.println	"return [day == ${showDay},\"\"];"
			out.println "}"

		}

		out.println "}).inputmask('mm/yyyy');";
		
		out.println "\$(jq(\"${dateElementId}\")).focusout(function() {"
			out.println "var dateText=\$(jq(\"${dateElementId}\")).val();"		
			out.println("var dateValue;")
			out.println "if(dateText != \"mm/yyyy\") {"
				out.println " var arr = dateText.split(\"/\");"
				out.println("dateValue = new Date(arr[1], arr[0]-1, \"01\")")
			out.println "} else {"
				out.println("dateValue = new Date(dateText)")
			out.println "}"
			
			out.println("if (!(isNaN(parseFloat(dateValue.getMonth())))) {")
			out.println "	\$(jq(\"${dateElementId}_month\")).attr(\"value\",dateValue.getMonth() +1);"
			out.println "	\$(jq(\"${dateElementId}_day\")).attr(\"value\",dateValue.getDate());"
			out.println "	\$(jq(\"${dateElementId}_year\")).attr(\"value\",dateValue.getFullYear());"
			out.println("} else {")
			out.println("\$(jq(\"${dateElementId}\")).val(\"\")")
			out.println "	\$(jq(\"${dateElementId}_month\")).attr(\"value\",\"\");"
			out.println "	\$(jq(\"${dateElementId}_day\")).attr(\"value\",\"\");"
			out.println "	\$(jq(\"${dateElementId}_year\")).attr(\"value\",\"\");"
			out.println("}")
		out.println "});"
		//Date fields are set as read only. This piece of code will allow the user to still delete (using backspace and delete buttons)
		//preventDefault is used so it does not post back to previous page when backspace button is used
		//this.focus so the calendar would open automatically when there is a validation error on that field
		out.println "\$('.onDeleteMandatory').bind('keypress keydown keyup', function(e) {"
		out.println "if ( e.keyCode == 8 || e.keyCode == 46){"
		out.println "\$.datepicker._clearDate(this);"
		out.println "\$(this).focus();"
		out.println "e.preventDefault();"
		out.println "}});"
		
		//Date fields are set as read only. This piece of code will allow the user to still delete (using backspace and delete buttons)
		//preventDefault is used so it does not post back to previous page when backspace button is used
		out.println "\$('.onDelete').bind('keypress keydown keyup', function(e) {"
		out.println "if ( e.keyCode == 8 || e.keyCode == 46){"
		out.println "\$.datepicker._clearDate(this);"
		out.println "e.preventDefault();"
		out.println "}});"
		if(!showIconDefault) {
			out.println "\$(jq(\"${calendarButtonId}\")).hide()";
		} else {
			out.println "\$(jq(\"${calendarButtonId}\")).show()";
		}
		out.println "})"

		out.println "</script>";

	}
	
	def lookUp = { attrs , body ->
		def elementId = attrs.lookupElementId
		def name = attrs.lookupElementName
		def value = attrs.lookupElementValue
		def cdoName = attrs.lookupCDOClassName
		def cdoAttr= attrs.lookupCDOClassAttribute
		def required = attrs.required

		def toUpd = attrs.htmlElementsToUpdate
		def toUpdCdo =attrs.htmlElementsToUpdateCDOProperty
		def toQuery =   attrs.htmlElementsToAddToQuery
		def toQueryCdo =   attrs.htmlElementsToAddToQueryCDOProperty

		if (elementId && name && cdoName && cdoAttr) {
			if(toQuery) {
			}
			String htmlString = new String()
			String textFieldHTML = "<input type=\"text\" name=\""+name+"\" value=\""+(value? value : "")+"\" id=\""+elementId+"\" style=\"${attrs.style}\" maxlength=\"${attrs.maxlength}\" size=\"${attrs.size}\" "
			if(required) {
				textFieldHTML = textFieldHTML.concat(' required=\"required\" ')
			}
			textFieldHTML = textFieldHTML.concat(">&nbsp;")
			String imageLocation = g.resource(dir: 'images', file: 'search-icon.png')
			String onClickHTML = "lookup('${elementId}' , "+
									" '${cdoName}','${cdoAttr}' , "+
									" ${toQuery?"'"+toQuery+"'" : null} , "+
									" ${toQueryCdo?"'"+toQueryCdo+"'": null} , "+
									" ${toUpd?"'"+toUpd+"'": null}, "+
									" ${toUpdCdo?"'"+toUpdCdo+"'": null}) "
			String magnifyingLensImage = "<a href=\"#\" onkeydown=\"if (event.keyCode == 13) document.getElementById('img_${elementId}').click()\"><img id=\"img_${elementId}\" width=\"15\" height=\"15\" style=\"float: none; vertical-align: bottom\" class=\"magnifying\" src=\"${imageLocation}\" onclick=\"${onClickHTML}\"></a>"
			htmlString = htmlString.concat(textFieldHTML)
			htmlString = htmlString.concat(magnifyingLensImage)
			out << (htmlString)
		}else{
			out << body()
		}
	}
	
	def phoneTextField = { attrs , body ->
		def out = out
		def dateElementName = attrs.dateElementName    //The name attribute is required for the tag to work seamlessly with grails
		def dateElementId = attrs.dateElementId
		def dateElementValue= attrs.dateElementValue
		def readOnly = attrs.readOnly
		def required = attrs.required
		def autofocus= attrs.autofocus
		//Code to parse selected date into hidden fields required by grails
		out.println "<script type=\"text/javascript\"> \$(document).ready(function(){"
		out.println "\$(jq(\"${dateElementId}\")).mask(\"999-999-9999\");"		
		out.println "});</script>"
		
		out.println "<input type=\"text\" value=\"${dateElementValue}\" name=\"${dateElementName}\" id=\"${dateElementId}\" "
		if(required) {
			out.print(' required=\"required\" ')
		}
		if(autofocus) {
			out.print(' autofocus=\"autofocus\" ')
		}
		out.println " "
		out.print ">";
	}

	
	def ssnTextField = { attrs , body ->
		def out = out
		def dateElementName = attrs.dateElementName    //The name attribute is required for the tag to work seamlessly with grails
		def dateElementId = attrs.dateElementId
		def dateElementValue= attrs.dateElementValue
		def readOnly = attrs.readOnly
		def required = attrs.required
		def autofocus = attrs.autofocus
		
		//Code to parse selected date into hidden fields required by grails
		out.println "<script type=\"text/javascript\"> \$(document).ready(function(){"
		out.println "\$(jq(\"${dateElementId}\")).mask(\"999999999\");"
		out.println "});</script>"
		
		out.print "<input type=\"text\" value=\"${dateElementValue}\" name=\"${dateElementName}\" id=\"${dateElementId}\" "
		if(required) {
			out.print(' required=\"required\" ')
		}
		if(autofocus) {
			out.print(' autofocus=\"autofocus\" ')
		}
		out.print ">";
	}
	
	def toolTip = { attrs, body ->
		def out = out
		def messagePropertyName = attrs.messagePropertyName
		def elementId = attrs.elementId
		def title = attrs.title
		
		String imageLocation = g.resource(dir: 'images', file: 'question-mark.png')
		out.println "<script type=\"text/javascript\"> \$(document).ready(function(){"
		out.println "\$(jq(\"${elementId}\")).qtip({"
		out.println " content: {"
		out.println " text: \$(jq(\"${elementId}\")).next(\'.tooltiptext\'), "
		out.println " title: \"${title}\""
		out.println " },"
		out.println "style: {		"
		out.println " },"
		out.println "hide: { "
		out.println "fixed: true, "
		out.println "delay: 300 "
		out.println "} "
		out.println "});"
		
		out.println "});</script>"
		
			
		out.println "<img id=\"${elementId}\" src=\"${imageLocation}\" style=\"width: 25px; height: 25px; vertical-align: bottom\">"
		out.println  "<div class=\"tooltiptext\" style=\"display: none\">"
		out.println g.message(code: "${messagePropertyName}")
		out.println " </div>"
	}
		
	//This is for UIUX sorting behaviour
		def sortableColumn  = {attrs, body ->
					
			if (!attrs.property) {
				throwTagError("Tag [sortableColumn] is missing required attribute [property]")
			}

			attrs.tabindex = "0";
			attrs.scope = "col"
			attrs.role = "columnheader"
			attrs.unselectable="on";
			attrs.'aria-sort' = "none"
			attrs.style = "-webkit-user-select: none;"	
			attrs.'aria-controls' = "SearchResults"
			attrs.'aria-label'= attrs.title + ": No sort applied, activate to apply a descending sort"
			attrs.id = attrs.property + attrs.'data-priority'; // To overcome same id conflicts. e.g. dob in member master->list.gsp
			
			String attrProp = attrs.property;
			String order = request.getParameter('order');
			String sort = request.getParameter('sort');
			//String defaultSortBy = attrs.remove("defaultSortBy");
			
			/*if (attrProp.equalsIgnoreCase(sort)){
				if(order == null){
					attrs.class += " tablesorter-headerUnSorted";
				} else if(order.equalsIgnoreCase("asc")){
					attrs.class += " tablesorter-headerAsc";
				} else {
					attrs.class += " tablesorter-headerDesc";
				}
			} else if ( (attrProp.equalsIgnoreCase(defaultSortBy)) && (sort == null)) {
					attrs.class += " tablesorter-headerAsc";
					//attrs.params.putAt("order", "asc")
					//attrs.params.order = "asc";
					//attrs.params.sort = defaultSortBy;
					//attrs.params.putAt("sort", defaultSortBy)
					request.getParameterMap().put("order", "asc");
					request.getParameterMap().put("sort", defaultSortBy);
					//this.pageScope."$params.order" = "asc";
					//this.pageScope."$params.sort" = defaultSortBy;
			}	else {
					attrs.class += " tablesorter-headerUnSorted";
			}*/
					 
			out << fmsui.sortableColumnRTL(attrs)
		}
		
		
		/**
		 * This code is copied from org.codehaus.groovy.grails.plugins.web.taglib.RenderTagLib.sortableColumn(...)
		 * Renders a sortable column to support sorting in list views.<br/>
		 *
		 * Attribute title or titleKey is required. When both attributes are specified then titleKey takes precedence,
		 * resulting in the title caption to be resolved against the message source. In case when the message could
		 * not be resolved, the title will be used as title caption.<br/>
		 *
		 * Examples:<br/>
		 *
		 * &lt;g:sortableColumn property="title" title="Title" /&gt;<br/>
		 * &lt;g:sortableColumn property="title" title="Title" style="width: 200px" /&gt;<br/>
		 * &lt;g:sortableColumn property="title" titleKey="book.title" /&gt;<br/>
		 * &lt;g:sortableColumn property="releaseDate" defaultOrder="desc" title="Release Date" /&gt;<br/>
		 * &lt;g:sortableColumn property="releaseDate" defaultOrder="desc" title="Release Date" titleKey="book.releaseDate" /&gt;<br/>
		 *
		 * @emptyTag
		 *
		 * @attr property - name of the property relating to the field
		 * @attr defaultOrder default order for the property; choose between asc (default if not provided) and desc
		 * @attr title title caption for the column
		 * @attr titleKey title key to use for the column, resolved against the message source
		 * @attr params a map containing request parameters
		 * @attr action the name of the action to use in the link, if not specified the list action will be linked
		 * @attr params A map containing URL query parameters
		 * @attr class CSS class name
		 */
		def sortableColumnRTL = { attrs ->
			def writer = out
			if (!attrs.property) {
				throwTagError("Tag [sortableColumn] is missing required attribute [property]")
			}
	
			if (!attrs.title && !attrs.titleKey) {
				throwTagError("Tag [sortableColumn] is missing required attribute [title] or [titleKey]")
			}
	
			def property = attrs.remove("property")
			def action = attrs.action ? attrs.remove("action") : (actionName ?: "list")
	
			def defaultOrder = attrs.remove("defaultOrder")
			if (defaultOrder != "desc") defaultOrder = "asc"
	
			// current sorting property and order
			def sort = params.sort
			def order = params.order
	
			// add sorting property and params to link params
			def linkParams = [:]
			if (params.id) linkParams.put("id", params.id)
			def paramsAttr = attrs.remove("params")
			if (paramsAttr) linkParams.putAll(paramsAttr)
			linkParams.sort = property
	
			// propagate "max" and "offset" standard params
			if (params.max) linkParams.max = params.max
			if (params.offset) linkParams.offset = params.offset
	
			// determine and add sorting order for this column to link params
			attrs.class = (attrs.class ? "${attrs.class} sortable" : "sortable")
			if (property == sort) {
				attrs.class = attrs.class + " sorted " + order
				if (order == "asc") {
					linkParams.order = "desc"
				}
				else {
					linkParams.order = "asc"
				}
			}
			else {
				linkParams.order = defaultOrder
			}
	
			// determine column title
			def title = attrs.remove("title")
			def titleKey = attrs.remove("titleKey")
			def mapping = attrs.remove('mapping')
			if (titleKey) {
				if (!title) title = titleKey
				def messageSource = grailsAttributes.messageSource
				def locale = RCU.getLocale(request)
				title = messageSource.getMessage(titleKey, null, title, locale)
			}
	
			
			def linkAttrs = [params: linkParams]
			if(mapping) {
				linkAttrs.mapping = mapping
			} else {
				linkAttrs.action = action
			}
			
			String tempStr = link(linkAttrs);
			tempStr = tempStr.replaceAll("<a ", "").replaceAll("></a>", "").replace("\"", "'");
			tempStr = tempStr.replace("href=", "");
			writer << "<th "
			//writer << "onclick=\"location."
			writer << "data-sorturl="
			writer << tempStr  
			// process remaining attributes
			attrs.each { k, v ->
				writer << "${k}=\"${v?.encodeAsHTML()}\" "
			}
			writer << '>'
			writer << '<div class="tablesorter-header-inner">'
			//writer << link(linkAttrs) {
			//	title
			//}
			
			writer <<title
			writer << '</div>'
			
			writer << '</th>'
		}
		def cdoLookup = { attrs , body ->
			def elementId = attrs.lookupElementId
			def name = attrs.lookupElementName
			def value = attrs.lookupElementValue
			def cdoName = attrs.lookupCDOClassName
			def cdoAttr= attrs.lookupCDOClassAttribute
			def toUpd = attrs.htmlElementsToUpdate
			def toUpdCdo =attrs.htmlElementsToUpdateCDOProperty
			def toQuery =   attrs.htmlElementsToAddToQuery
			def toQueryCdo =   attrs.htmlElementsToAddToQueryCDOProperty
	
			if (elementId && name && cdoName && cdoAttr) {
				if(toQuery) {
				}
				String htmlString = new String()
				String lookupButton = "<button type=\"button\" id=\"Btn_${elementId}\" class=\"btn fms_btn_icon btn-sm fms_form_control_feedback\" title=\"Click to do full search.\"";
				lookupButton = lookupButton.concat (" onkeydown=\"if (event.keyCode == 13) this.click()\" onclick=\"openLookup('"+elementId+"', '"+cdoName+"','"+cdoAttr+"','"+toQuery+"','"+toQueryCdo+"','"+toUpd+"', '"+toUpdCdo+"')\">");
				lookupButton = lookupButton.concat ("<i class=\"glyphicon glyphicon-search\"></i></button>")
				htmlString = htmlString.concat(lookupButton)
				out << (htmlString)
			}else{
				out << body()
			}
		}
		
}
