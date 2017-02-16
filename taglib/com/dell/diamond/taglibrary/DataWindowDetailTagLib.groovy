package com.dell.diamond.taglibrary

import com.perotsystems.diamond.dao.cdo.DddwDtl
import com.perotsystems.diamond.dao.cdo.UserDefinedText
import java.lang.reflect.Method

// Sekar: Test for CM / cvs update build issue - 3rd try
class DataWindowDetailTagLib {
	def diamondDataRetrivalService
	def securityService
	def  getDiamondDataWindowDetail = {attrs, body ->
		String columnName = attrs.columnName
		String dwName = attrs.dwName
		String languageId = attrs.languageId
		String htmlElelmentId = attrs.htmlElelmentId
		String defaultValue = attrs.defaultValue
		String blankVale = attrs.blankValue
		String width = attrs.width
		String disable=attrs.disable
		String onchange=attrs.onchange	
		String title=attrs.title
		String cssClass=attrs.cssClass
		
		if (columnName && dwName && languageId && htmlElelmentId) {
			
			//println "columnName =" +columnName +" dwName= "+dwName+ " languageId= "+ languageId + " htmlElelmentId ="+htmlElelmentId
			ArrayList dddwDtlList = diamondDataRetrivalService.getDiamondDataWindowDetail (columnName, dwName, languageId)
			String htmlString;
			if(disable){
			htmlString = '<select  '+disable+' name="'+htmlElelmentId+'" id="'+htmlElelmentId+'" class="'+cssClass+'"'
			}
			else{
			htmlString = '<select  name="'+htmlElelmentId+'" id="'+htmlElelmentId+'" class="'+cssClass+'"' 
			}
			
			if (width) {
				htmlString = htmlString.concat(" style='width:${width}'")
			}
			
			if (title) {
				htmlString = htmlString.concat(" title='" + title + "'" )
			}
			
			if(disable && onchange){
			htmlString = htmlString.concat ('onchange="'+onchange+'"')
			}
			htmlString = htmlString.concat ('>')
			
			if (blankVale) {
				htmlString = htmlString.concat('<option value="">-- Select the '+blankVale+' --</option>')
			}
			dddwDtlList.each { detail ->
				String selectedText = detail.dataVal.equals(defaultValue) ? "selected" : ""
				htmlString = htmlString.concat('<option value="'+ detail.dataVal+'" '+selectedText+'>'+ detail.displayVal+'</option>')
			}
			htmlString = htmlString.concat('</select>')
			//println htmlString
			
			out << (htmlString)
			out << body()
		}
	}
	
	def  getSystemCodeToken= {attrs, body ->
		String systemCodeType = attrs.systemCodeType
		String languageId = attrs.languageId
		String htmlElelmentId = attrs.htmlElelmentId
		String defaultValue = attrs.defaultValue
		String blankVale = attrs.blankValue
		String width = attrs.width
		String disable=attrs.disable
		String sort = attrs.sort
		String sortOrder = attrs.sortOrder
		String title=attrs.title
		String cssClass = attrs.cssClass
		
		
		if (systemCodeType && languageId && htmlElelmentId) {
			
			//println "columnName =" +systemCodeType + " languageId= "+ languageId + " htmlElelmentId ="+htmlElelmentId
		    ArrayList dddwDtlList = diamondDataRetrivalService.getSystemCodeTokens (systemCodeType, languageId, sort, sortOrder)
			String htmlString = ""
			if(disable){
				htmlString = '<select disabled="'+disable+'" name="'+htmlElelmentId+'" id="'+htmlElelmentId+'" class="'+cssClass+'"'                 
				}
				else{
				htmlString = '<select name="'+htmlElelmentId+'" id="'+htmlElelmentId+'" class="'+cssClass+'"'
				}
			if (width) {
				htmlString = htmlString.concat(" style='width:${width}'")
			}
			if (title) {
				htmlString = htmlString.concat(" title='" + title + "'" )
			}
			htmlString = htmlString.concat ('>')
			if (blankVale) {
				htmlString = htmlString.concat('<option value="">-- Select the '+blankVale+' --</option>')
			}
			dddwDtlList.each { detail ->
				String selectedText = detail.systemCode.equals(defaultValue) ? "selected" : ""
				htmlString = htmlString.concat('<option value="'+ detail.systemCode+'" '+selectedText+'>'+ detail.systemCode + ' - ' +detail.systemCodeDesc2+'</option>')
			}
			htmlString = htmlString.concat('</select>')
			//println htmlString
			
			out << (htmlString)
			out << body()
		}
	}
	
	
	def  getSystemCodes= {attrs, body ->
		String systemCodeType = attrs.systemCodeType
		String systemCodeActive = attrs.systemCodeActive
		String systemCode = attrs.systemCode
		String htmlElelmentId = attrs.htmlElelmentId
		String defaultValue = attrs.defaultValue
		String blankVale = attrs.blankValue
		String width = attrs.width
		String disable=attrs.disable
		String sort = attrs.sort
		String sortOrder = attrs.sortOrder
		String title=attrs.title
		String cssClass = attrs.cssClass
		String onchange=attrs.onchange
		String autofocus = attrs.autofocus
		
		
		if (systemCodeType && htmlElelmentId) {
			
			//println "columnName =" +systemCodeType + " languageId= "+ languageId + " htmlElelmentId ="+htmlElelmentId
			ArrayList dddwDtlList = diamondDataRetrivalService.getSystemCodes (systemCodeType, systemCodeActive?.toUpperCase(), systemCode?.toUpperCase(), sort, sortOrder)
			String htmlString = ""
			if(disable){
				htmlString = '<select disabled="'+disable+'" name="'+htmlElelmentId+'" id="'+htmlElelmentId+'" class="'+cssClass+'"'
				}
				else{
				htmlString = '<select name="'+htmlElelmentId+'" id="'+htmlElelmentId+'" class="'+cssClass+'"'
				}
			if (width) {
				htmlString = htmlString.concat(" style='width:${width}'")
			}
			if (title) {
				htmlString = htmlString.concat(" title='" + title + "'" )
			}
			if (autofocus) {
				htmlString = htmlString.concat(" autofocus='" + autofocus + "'" )
			}
			if(onchange){
				htmlString = htmlString.concat(" onchange=\"" + onchange + "\"" )
			}
			htmlString = htmlString.concat ('>')
			if (blankVale) {
				htmlString = htmlString.concat('<option value="">-- Select the '+blankVale+' --</option>')
			}
			dddwDtlList.each { detail ->
				String selectedText = detail.systemCode.equals(defaultValue) ? "selected" : ""
				htmlString = htmlString.concat('<option value="'+ detail.systemCode+'" '+selectedText+'>'+ detail.systemCode + ' - ' +detail.systemCodeDesc2+'</option>')
			}
			htmlString = htmlString.concat('</select>')
			//println htmlString
			
			out << (htmlString)
			out << body()
		}
	}

	def  getCdoSelectBox= {attrs, body ->
		String cdoAttributeWhere = attrs.cdoAttributeWhere
		String cdoAttributeWhereValue = attrs.cdoAttributeWhereValue
		
		String cdoClassName = attrs.cdoClassName
		String cdoAttributeSelect = attrs.cdoAttributeSelect
		String cdoAttributeSelectDesc = attrs.cdoAttributeSelectDesc
		String languageId = attrs.languageId
		String htmlElelmentId = attrs.htmlElelmentId
		String defaultValue = attrs.defaultValue
		String blankVale = attrs.blankValue
		String width = attrs.width
		String disable=attrs.disable
		String title=attrs.title
		String className=attrs.className
		String onchange=attrs.onchange
		if (cdoAttributeSelect && cdoAttributeWhere && cdoAttributeWhereValue &&languageId && htmlElelmentId) {
			
			//println "columnName =" +systemCodeType + " languageId= "+ languageId + " htmlElelmentId ="+htmlElelmentId
			ArrayList cdoObjectList = diamondDataRetrivalService.getCdoObjects (cdoClassName, cdoAttributeWhere,  cdoAttributeWhereValue, languageId)
			String htmlString;
			if(disable){
				htmlString = '<select '+disable+' name="'+htmlElelmentId+'" id="'+htmlElelmentId+'"'
			}else{
			htmlString = '<select name="'+htmlElelmentId+'" id="'+htmlElelmentId+'"'
			}
			if (width) {
				htmlString = htmlString.concat(" style='width:${width}'")
			}
			if (title) {
				htmlString = htmlString.concat(" title='" + title + "'" )
			}
			if (className) {
				htmlString = htmlString.concat(" class='" + className + "'" )
			}
		
			if(onchange){
				htmlString = htmlString.concat(" onchange=\"" + onchange + "\"" )
			}
			htmlString = htmlString.concat ('>')
			if (blankVale) {
				htmlString = htmlString.concat('<option value="">-- Select the '+blankVale+' --</option>')
			}
			cdoObjectList.each { detail ->
				
				def getMethod1 = "get"+(toTitleCase(cdoAttributeSelect))
				def getMethod2 = "get"+(toTitleCase(cdoAttributeSelectDesc))
				//System.out.println ("**********************getMethod1 = " + getMethod1 + " *****************getMethod2 = " + getMethod2)

				Method methodshortDesc = detail.getClass().getMethod(getMethod1)
				Method methodLongDesc = detail.getClass().getMethod(getMethod2)
				String shortDesc = methodshortDesc.invoke(detail, null)
				String longDesc = methodLongDesc.invoke(detail, null)
				String selectedText = shortDesc.equals(defaultValue) ? "selected" : ""
				htmlString = htmlString.concat('<option value="'+ shortDesc +'" '+selectedText+'>'+ shortDesc + " - " +longDesc+'</option>')
			}
			htmlString = htmlString.concat('</select>')
			//println htmlString
			
			out << (htmlString)
			out << body()
		}
	}
	
	private String toTitleCase(String sample) {
		if (sample) {
			sample = String.valueOf(sample.charAt(0).toUpperCase()) + (sample.substring(1, sample.length()))
			return sample
		}
	}
	
	def userDefinedFieldLabel= {attrs, body ->
		
		/* <g:message
						code="user.userDefined1.label" default="User Defined 1: " />
						*/
		String winId = attrs.winId
		String datawindowId = attrs.datawindowId
		String userDefineTextName = attrs.userDefineTextName
		String languageId = attrs.languageId
		String defaultText = attrs.defaultText
		
		String htmlString = new String()
		String isHeader = attrs.isHeader
		
		//set default value for languageId
		if(!languageId)		
		 languageId=0
		if(!defaultText)
		defaultText=userDefineTextName
		 
		
		ArrayList userDefinedFieldList = diamondDataRetrivalService.getUserDefinedFields(winId, datawindowId,userDefineTextName,languageId)
		//if UDT is not defined then return the userDefineTextName
		if(userDefinedFieldList && userDefinedFieldList.size() > 0  )		{
			UserDefinedText userDefinedText =(UserDefinedText) userDefinedFieldList.get(0)		
			//if text is blank in database
			if(userDefinedText.userDefineText && userDefinedText.userDefineText.trim().length() > 0 ){
				htmlString = userDefinedText.userDefineText
				if(!htmlString.contains(":") && !isHeader) htmlString = htmlString + ":"
			} 	
				else
				htmlString =defaultText + ":"				
			}		
		else{
			//not defined in DB
			htmlString = defaultText + ":"
		}						
		out << (htmlString)
		out << body()		
		
	}
	
	
	def secColDetailColumn = {attrs, body ->
		String clazzName = attrs.clazzName
		String selectedValue = attrs.selectedValue
		String idName = attrs.idName
		String disabled = attrs.disabled
		String title = attrs.title
		
		//println "selected = " + selectedValue
		Class seColGroovyClass = null;

		try {
			seColGroovyClass = securityService.getClass(clazzName)
		} catch (Exception ex) {
			out << "Unable to find the class com.dell.diamond.fms.sfldl.enums.${clazzName} to fetch Columns."
			return
		}
		ArrayList columnNames = new ArrayList()
		if (seColGroovyClass) {
			seColGroovyClass.values().each {def class1 ->
				//println class1.cdoVarName() + " = "+ class1.mask()
				if (!class1.mask()) {
					columnNames.add(class1.colName())
				}
			}
		}
		//println "columnNames = " + columnNames
		out << g.select(id:idName, name:idName, disabled: disabled,
		from:columnNames, noSelection:['':'-- Select the Column name--'], value: selectedValue , title: title
		)
	}
	
}
