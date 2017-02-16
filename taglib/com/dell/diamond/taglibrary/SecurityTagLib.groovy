package com.dell.diamond.taglibrary

import java.text.SimpleDateFormat

import javax.servlet.http.HttpSession

import com.dell.diamond.fms.sfldl.FieldLevelSecurityTableEnum
import com.dell.diamond.fms.sfldl.SecuredFieldDescription
import com.dell.diamond.fms.sfldl.enums.FieldSecurityIndicatorEnum
import com.dell.diamond.service.auth.SecurityService
import com.dell.diamond.util.services.DiamondDataRetrivalService
import com.perotsystems.diamond.tools.build.cdo.Util

class SecurityTagLib {
	SecurityService securityService
	DiamondDataRetrivalService diamondDataRetrivalService

	def checkURIAuthorization  = {attrs, body ->
		boolean hasAccess = true
		String uri = attrs.uri
		boolean isDisabled = securityService.checkModuleEnabled(uri)
		if (!isDisabled) {
			String htmlString = "<div style='display:block;display: inline;'>"
			String closingTag = "</div>"
			if (uri) {
				hasAccess = securityService.authorizeURI(uri)
				if (!hasAccess) {
					htmlString = "<div style='display:none'>"
				}
			}
	
			out << (htmlString)
			if (hasAccess) {
				out << body()
			}
			out << (closingTag)
		} else {
			out << ""
		}
	}
	
	def checkMenuURIAuthorization  = {attrs, body ->
		boolean hasAccess = true
		String uri = attrs.uri
		boolean isDisabled = securityService.checkModuleEnabled(uri)
		if (!isDisabled) {
			String htmlString = ""
			String closingTag = ""
			if (uri) {
				hasAccess = securityService.authorizeURI(uri)
				if (!hasAccess) {
					htmlString = "<div style='display:none'>"
					closingTag = "</div>"
				}
			}
	
			out << (htmlString)
			if (hasAccess) {
				out << body()
			}
			out << (closingTag)
		} else {
			out << ""
		}
	}

	def checkModuleEnabled = {attrs, body ->
		String module = attrs.module
		if(module) {
			boolean isModuleDisabled = securityService.checkModuleEnabled(module)
			if(!isModuleDisabled) {
				out << body()
			}
		} else {
			out << body()
		}
	}

	def secureTextField = { attrs, body ->
		String tableName = attrs.tableName
		String attributeName = attrs.attributeName
		HttpSession httpSession = request.getSession()
		boolean isSecured = false
		boolean isEditable = true
		boolean isViewable = true
		String htmlString = "&nbsp;"
		FieldLevelSecurityTableEnum tableNameEnum = FieldLevelSecurityTableEnum.bytableName(tableName)
		String seColGroovyClassName = Util.dbNameToJavaName (tableName, true)+  SecurityService.SEC_COL_CLASS_NAME_SUFFIX
		Class seColGroovyClass = null;
		def columnEnum = null;
		try {
			seColGroovyClass = securityService.getClass(seColGroovyClassName)
		} catch (Exception ex) {
			htmlString = "Unable to find the class com.dell.diamond.fms.sfldl.enums.${seColGroovyClassName} to fetch Field level security attributes. Check Table Name attribute in the tag."
			out << (htmlString)
			return
		}
		if (seColGroovyClass  ) {
			columnEnum = seColGroovyClass.bycdoVarName(attributeName)
		}
		if (columnEnum == null ||  columnEnum.mask() == null) {
			htmlString = " This field ${attributeName} is a masked field, invalid Configuration, please regenerate the enum to unmask."
			out << (htmlString)
			return
		} else {
			String sfldlId = httpSession.getAttribute(SecurityService.SFLDLID)
			if (sfldlId && tableNameEnum && columnEnum) {
				HashMap<String, SecuredFieldDescription> secColMap = httpSession.getAttribute(SecurityService.FIELD_LEVEL_SECURITY_MAP)

				if (secColMap!=null && !secColMap.containsKey(tableNameEnum)) {
					 securityService.populateFieldLevelSecurity(sfldlId, httpSession, tableNameEnum)
					 secColMap=httpSession.getAttribute(SecurityService.FIELD_LEVEL_SECURITY_MAP)
				}

				ArrayList<SecuredFieldDescription> secFieldDescList = secColMap.get(tableNameEnum)
				if (secFieldDescList) {
					for(SecuredFieldDescription secFieldDesc : secFieldDescList ) {
						if (secFieldDesc.securedFieldDetailEnum.cdoVarName()?.equals(attributeName)) {
							if (secFieldDesc.fieldAccessEnum.equals(FieldSecurityIndicatorEnum.PROHIBIT_CHANGE)) {
								isEditable = false
								break;
							} else if (secFieldDesc.fieldAccessEnum.equals(FieldSecurityIndicatorEnum.PROHIBIT_VIEW)){
								isViewable = false
								break;
							}
						}
					}
				}
			}
			if (!isEditable) {
				htmlString = attrs.value
				out << htmlString
				return
			} else if (!isViewable) {
				out << htmlString
				return
			} else {
				out << g.textField(attrs, body)
				return
			}
		}
	}
	
	def secureCheckBox = { attrs, body ->
		String tableName = attrs.tableName
		String attributeName = attrs.attributeName
		HttpSession httpSession = request.getSession()
		boolean isSecured = false
		boolean isEditable = true
		boolean isViewable = true
		String htmlString = "&nbsp;"
		FieldLevelSecurityTableEnum tableNameEnum = FieldLevelSecurityTableEnum.bytableName(tableName)
		String seColGroovyClassName = Util.dbNameToJavaName (tableName, true)+  SecurityService.SEC_COL_CLASS_NAME_SUFFIX
		Class seColGroovyClass = null;
		def columnEnum = null;
		try {
			seColGroovyClass = securityService.getClass(seColGroovyClassName)
		} catch (Exception ex) {
			htmlString = "Unable to find the class com.dell.diamond.fms.sfldl.enums.${seColGroovyClassName} to fetch Field level security attributes. Check Table Name attribute in the tag."
			out << (htmlString)
			return
		}
		if (seColGroovyClass  ) {
			columnEnum = seColGroovyClass.bycdoVarName(attributeName)
		}
		if (columnEnum == null ||  columnEnum.mask() == null) {
			htmlString = " This field ${attributeName} is a masked field, invalid Configuration, please regenerate the enum to unmask."
			out << (htmlString)
			return
		} else {
			String sfldlId = httpSession.getAttribute(SecurityService.SFLDLID)
			if (sfldlId && tableNameEnum && columnEnum) {
				HashMap<String, SecuredFieldDescription> secColMap = httpSession.getAttribute(SecurityService.FIELD_LEVEL_SECURITY_MAP)

				if (secColMap!=null && !secColMap.containsKey(tableNameEnum)) {
					 securityService.populateFieldLevelSecurity(sfldlId, httpSession, tableNameEnum)
					 secColMap=httpSession.getAttribute(SecurityService.FIELD_LEVEL_SECURITY_MAP)
				}

				ArrayList<SecuredFieldDescription> secFieldDescList = secColMap.get(tableNameEnum)
				if (secFieldDescList) {
					for(SecuredFieldDescription secFieldDesc : secFieldDescList ) {
						if (secFieldDesc.securedFieldDetailEnum.cdoVarName()?.equals(attributeName)) {
							if (secFieldDesc.fieldAccessEnum.equals(FieldSecurityIndicatorEnum.PROHIBIT_CHANGE)) {
								isEditable = false
								break;
							} else if (secFieldDesc.fieldAccessEnum.equals(FieldSecurityIndicatorEnum.PROHIBIT_VIEW)){
								isViewable = false
								break;
							}
						}
					}
				}
			}
			if (!isEditable) {
				htmlString = attrs.value
				out << htmlString
				return
			} else if (!isViewable) {
				out << htmlString
				return
			} else {
				out << g.checkBox(attrs, body)
				return
			}
		}
	}
	
	def secureComboBox = { attrs, body ->
		String tableName = attrs.tableName
		String attributeName = attrs.attributeName
		HttpSession httpSession = request.getSession()
		boolean isSecured = false
		boolean isEditable = true
		boolean isViewable = true
		String htmlString = "&nbsp;"
		FieldLevelSecurityTableEnum tableNameEnum = FieldLevelSecurityTableEnum.bytableName(tableName)
		String seColGroovyClassName = Util.dbNameToJavaName (tableName, true)+ "SecColDetailEnum"
		Class seColGroovyClass = null;
		def columnEnum = null;
		try {
			seColGroovyClass = securityService.getClass(seColGroovyClassName)
		} catch (Exception ex) {
			htmlString = "Unable to find the class com.dell.diamond.fms.sfldl.enums.${seColGroovyClassName} to fetch Field level security attributes. Check Table Name attribute in the tag."
			out << (htmlString)
			return
		}
		if (seColGroovyClass  ) {
			columnEnum = seColGroovyClass.bycdoVarName(attributeName)
		}
		if (columnEnum == null ||  columnEnum.mask() == null) {
			htmlString = " This field ${attributeName} is a masked field, invalid Configuration, please regenerate the enum to unmask."
			out << (htmlString)
			return
		} else {
			String sfldlId = httpSession.getAttribute(SecurityService.SFLDLID)
			if (sfldlId && tableNameEnum && columnEnum) {
				HashMap<String, SecuredFieldDescription> secColMap = httpSession.getAttribute(SecurityService.FIELD_LEVEL_SECURITY_MAP)

				if (secColMap!=null && !secColMap.containsKey(tableNameEnum)) {
					securityService.populateFieldLevelSecurity(sfldlId, httpSession, tableNameEnum)
					secColMap=httpSession.getAttribute(SecurityService.FIELD_LEVEL_SECURITY_MAP)
				}

				ArrayList<SecuredFieldDescription> secFieldDescList = secColMap.get(tableNameEnum)
				if (secFieldDescList) {
					for(SecuredFieldDescription secFieldDesc : secFieldDescList ) {
						if (secFieldDesc.securedFieldDetailEnum.cdoVarName()?.equals(attributeName)) {
							if (secFieldDesc.fieldAccessEnum.equals(FieldSecurityIndicatorEnum.PROHIBIT_CHANGE)) {
								isEditable = false
								break;
							} else if (secFieldDesc.fieldAccessEnum.equals(FieldSecurityIndicatorEnum.PROHIBIT_VIEW)){
								isViewable = false
								break;
							}
						}
					}
				}
			}
			if (!isEditable) {
				htmlString = attrs.value
				out << htmlString
				return
			} else if (!isViewable) {
				out << htmlString
				return
			} else {
				out << g.select(attrs)
				return
			}
		}
	}
	
	def secureDiamondDataWindowDetail = { attrs, body ->
		String tableName = attrs.tableName
		String attributeName = attrs.attributeName
		HttpSession httpSession = request.getSession()
		boolean isSecured = false
		boolean isEditable = true
		boolean isViewable = true
		String htmlString = "&nbsp;"
		FieldLevelSecurityTableEnum tableNameEnum = FieldLevelSecurityTableEnum.bytableName(tableName)
		String seColGroovyClassName = Util.dbNameToJavaName (tableName, true)+ "SecColDetailEnum"
		Class seColGroovyClass = null;
		def columnEnum = null;
		try {
			seColGroovyClass = securityService.getClass(seColGroovyClassName)
		} catch (Exception ex) {
			htmlString = "Unable to find the class com.dell.diamond.fms.sfldl.enums.${seColGroovyClassName} to fetch Field level security attributes. Check Table Name attribute in the tag."
			out << (htmlString)
			return
		}
		if (seColGroovyClass  ) {
			columnEnum = seColGroovyClass.bycdoVarName(attributeName)
		}
		if (columnEnum == null ||  columnEnum.mask() == null) {
			htmlString = " This field ${attributeName} is a masked field, invalid Configuration, please regenerate the enum to unmask."
			out << (htmlString)
			return
		} else {
			String sfldlId = httpSession.getAttribute(SecurityService.SFLDLID)
			if (sfldlId && tableNameEnum && columnEnum) {
				HashMap<String, SecuredFieldDescription> secColMap = httpSession.getAttribute(SecurityService.FIELD_LEVEL_SECURITY_MAP)

				if (secColMap!=null && !secColMap.containsKey(tableNameEnum)) {
					securityService.populateFieldLevelSecurity(sfldlId, httpSession, tableNameEnum)
					secColMap=httpSession.getAttribute(SecurityService.FIELD_LEVEL_SECURITY_MAP)
				}

				ArrayList<SecuredFieldDescription> secFieldDescList = secColMap.get(tableNameEnum)
				if (secFieldDescList) {
					for(SecuredFieldDescription secFieldDesc : secFieldDescList ) {
						if (secFieldDesc.securedFieldDetailEnum.cdoVarName()?.equals(attributeName)) {
							if (secFieldDesc.fieldAccessEnum.equals(FieldSecurityIndicatorEnum.PROHIBIT_CHANGE)) {
								isEditable = false
								break;
							} else if (secFieldDesc.fieldAccessEnum.equals(FieldSecurityIndicatorEnum.PROHIBIT_VIEW)){
								isViewable = false
								break;
							}
						}
					}
				}
			}
			if (!isEditable) {
				htmlString = attrs.value
				out << htmlString
				return
			} else if (!isViewable) {
				out << htmlString
				return
			} else {
				out << g.getDiamondDataWindowDetail(attrs)
				return
			}
		}
	}
	
	def secureSystemCodeToken = { attrs, body ->
		String tableName = attrs.tableName
		String attributeName = attrs.attributeName
		HttpSession httpSession = request.getSession()
		boolean isSecured = false
		boolean isEditable = true
		boolean isViewable = true
		String htmlString = "&nbsp;"
		FieldLevelSecurityTableEnum tableNameEnum = FieldLevelSecurityTableEnum.bytableName(tableName)
		String seColGroovyClassName = Util.dbNameToJavaName (tableName, true)+ "SecColDetailEnum"
		Class seColGroovyClass = null;
		def columnEnum = null;
		try {
			seColGroovyClass = securityService.getClass(seColGroovyClassName)
		} catch (Exception ex) {
			htmlString = "Unable to find the class com.dell.diamond.fms.sfldl.enums.${seColGroovyClassName} to fetch Field level security attributes. Check Table Name attribute in the tag."
			out << (htmlString)
			return
		}
		if (seColGroovyClass  ) {
			columnEnum = seColGroovyClass.bycdoVarName(attributeName)
		}
		if (columnEnum == null ||  columnEnum.mask() == null) {
			htmlString = " This field ${attributeName} is a masked field, invalid Configuration, please regenerate the enum to unmask."
			out << (htmlString)
			return
		} else {
			String sfldlId = httpSession.getAttribute(SecurityService.SFLDLID)
			if (sfldlId && tableNameEnum && columnEnum) {
				HashMap<String, SecuredFieldDescription> secColMap = httpSession.getAttribute(SecurityService.FIELD_LEVEL_SECURITY_MAP)

				if (secColMap!=null && !secColMap.containsKey(tableNameEnum)) {
					securityService.populateFieldLevelSecurity(sfldlId, httpSession, tableNameEnum)
					secColMap=httpSession.getAttribute(SecurityService.FIELD_LEVEL_SECURITY_MAP)
				}

				ArrayList<SecuredFieldDescription> secFieldDescList = secColMap.get(tableNameEnum)
				if (secFieldDescList) {
					for(SecuredFieldDescription secFieldDesc : secFieldDescList ) {
						if (secFieldDesc.securedFieldDetailEnum.cdoVarName()?.equals(attributeName)) {
							if (secFieldDesc.fieldAccessEnum.equals(FieldSecurityIndicatorEnum.PROHIBIT_CHANGE)) {
								isEditable = false
								break;
							} else if (secFieldDesc.fieldAccessEnum.equals(FieldSecurityIndicatorEnum.PROHIBIT_VIEW)){
								isViewable = false
								break;
							}
						}
					}
				}
			}
			if (!isEditable) {
				htmlString = attrs.defaultValue
				out << htmlString
				return
			} else if (!isViewable) {
				out << htmlString
				return
			} else {
				out << g.getSystemCodeToken(attrs)
				return
			}
		}
	}
	
	def secureSystemCodes = { attrs, body ->
		String tableName = attrs.tableName
		String attributeName = attrs.attributeName
		HttpSession httpSession = request.getSession()
		boolean isSecured = false
		boolean isEditable = true
		boolean isViewable = true
		String htmlString = "&nbsp;"
		FieldLevelSecurityTableEnum tableNameEnum = FieldLevelSecurityTableEnum.bytableName(tableName)
		String seColGroovyClassName = Util.dbNameToJavaName (tableName, true)+ "SecColDetailEnum"
		Class seColGroovyClass = null;
		def columnEnum = null;
		try {
			seColGroovyClass = securityService.getClass(seColGroovyClassName)
		} catch (Exception ex) {
			htmlString = "Unable to find the class com.dell.diamond.fms.sfldl.enums.${seColGroovyClassName} to fetch Field level security attributes. Check Table Name attribute in the tag."
			out << (htmlString)
			return
		}
		if (seColGroovyClass  ) {
			columnEnum = seColGroovyClass.bycdoVarName(attributeName)
		}
		if (columnEnum == null ||  columnEnum.mask() == null) {
			htmlString = " This field ${attributeName} is a masked field, invalid Configuration, please regenerate the enum to unmask."
			out << (htmlString)
			return
		} else {
			String sfldlId = httpSession.getAttribute(SecurityService.SFLDLID)
			if (sfldlId && tableNameEnum && columnEnum) {
				HashMap<String, SecuredFieldDescription> secColMap = httpSession.getAttribute(SecurityService.FIELD_LEVEL_SECURITY_MAP)

				if (secColMap!=null && !secColMap.containsKey(tableNameEnum)) {
					securityService.populateFieldLevelSecurity(sfldlId, httpSession, tableNameEnum)
					secColMap=httpSession.getAttribute(SecurityService.FIELD_LEVEL_SECURITY_MAP)
				}

				ArrayList<SecuredFieldDescription> secFieldDescList = secColMap.get(tableNameEnum)
				if (secFieldDescList) {
					for(SecuredFieldDescription secFieldDesc : secFieldDescList ) {
						if (secFieldDesc.securedFieldDetailEnum.cdoVarName()?.equals(attributeName)) {
							if (secFieldDesc.fieldAccessEnum.equals(FieldSecurityIndicatorEnum.PROHIBIT_CHANGE)) {
								isEditable = false
								break;
							} else if (secFieldDesc.fieldAccessEnum.equals(FieldSecurityIndicatorEnum.PROHIBIT_VIEW)){
								isViewable = false
								break;
							}
						}
					}
				}
			}
			if (!isEditable) {
				ArrayList dddwDtlList = diamondDataRetrivalService.getSystemCodes(attrs.systemCodeType, attrs.systemCodeActive?.toUpperCase(), attrs.defaultValue?.toUpperCase())
				dddwDtlList.each { detail ->
					htmlString = htmlString.concat(detail.systemCode + ' - ' +detail.systemCodeDesc2)
				}
				out << htmlString
				return
			} else if (!isViewable) {
				out << htmlString
				return
			} else {
				out << g.getSystemCodes(attrs)
				return
			}
		}
	}
	
	def secureCdoSelectBox = { attrs, body ->
		String tableName = attrs.tableName
		String attributeName = attrs.attributeName
		HttpSession httpSession = request.getSession()
		boolean isSecured = false
		boolean isEditable = true
		boolean isViewable = true
		String htmlString = "&nbsp;"
		FieldLevelSecurityTableEnum tableNameEnum = FieldLevelSecurityTableEnum.bytableName(tableName)
		String seColGroovyClassName = Util.dbNameToJavaName (tableName, true)+ "SecColDetailEnum"
		Class seColGroovyClass = null;
		def columnEnum = null;
		try {
			seColGroovyClass = securityService.getClass(seColGroovyClassName)
		} catch (Exception ex) {
			htmlString = "Unable to find the class com.dell.diamond.fms.sfldl.enums.${seColGroovyClassName} to fetch Field level security attributes. Check Table Name attribute in the tag."
			out << (htmlString)
			return
		}
		if (seColGroovyClass  ) {
			columnEnum = seColGroovyClass.bycdoVarName(attributeName)
		}
		if (columnEnum == null ||  columnEnum.mask() == null) {
			htmlString = " This field ${attributeName} is a masked field, invalid Configuration, please regenerate the enum to unmask."
			out << (htmlString)
			return
		} else {
			String sfldlId = httpSession.getAttribute(SecurityService.SFLDLID)
			if (sfldlId && tableNameEnum && columnEnum) {
				HashMap<String, SecuredFieldDescription> secColMap = httpSession.getAttribute(SecurityService.FIELD_LEVEL_SECURITY_MAP)

				if (secColMap!=null && !secColMap.containsKey(tableNameEnum)) {
					securityService.populateFieldLevelSecurity(sfldlId, httpSession, tableNameEnum)
					secColMap=httpSession.getAttribute(SecurityService.FIELD_LEVEL_SECURITY_MAP)
				}

				ArrayList<SecuredFieldDescription> secFieldDescList = secColMap.get(tableNameEnum)
				if (secFieldDescList) {
					for(SecuredFieldDescription secFieldDesc : secFieldDescList ) {
						if (secFieldDesc.securedFieldDetailEnum.cdoVarName()?.equals(attributeName)) {
							if (secFieldDesc.fieldAccessEnum.equals(FieldSecurityIndicatorEnum.PROHIBIT_CHANGE)) {
								isEditable = false
								break;
							} else if (secFieldDesc.fieldAccessEnum.equals(FieldSecurityIndicatorEnum.PROHIBIT_VIEW)){
								isViewable = false
								break;
							}
						}
					}
				}
			}
			if (!isEditable) {
				htmlString = attrs.value
				out << htmlString
				return
			} else if (!isViewable) {
				out << htmlString
				return
			} else {
				out << g.getCdoSelectBox(attrs)
				return
			}
		}
	}
	
	
	def secureGrailsDatePicker = { attrs, body ->
		String tableName = attrs.tableName
		String attributeName = attrs.attributeName
		HttpSession httpSession = request.getSession()
		boolean isSecured = false
		boolean isEditable = true
		boolean isViewable = true
		String htmlString = ""
		FieldLevelSecurityTableEnum tableNameEnum = FieldLevelSecurityTableEnum.bytableName(tableName)
		String seColGroovyClassName = Util.dbNameToJavaName (tableName, true)+ "SecColDetailEnum"
		Class seColGroovyClass = null;
		def columnEnum = null;
		try {
			seColGroovyClass = securityService.getClass(seColGroovyClassName)
		} catch (Exception ex) {
			htmlString = "Unable to find the class com.dell.diamond.fms.sfldl.enums.${seColGroovyClassName} to fetch Field level security attributes. Check Table Name attribute in the tag."
			out << (htmlString)
			return
		}
		if (seColGroovyClass  ) {
			columnEnum = seColGroovyClass.bycdoVarName(attributeName)
		}
		if (columnEnum == null ||  columnEnum.mask() == null) {
			htmlString = " This field ${attributeName} is a masked field, invalid Configuration, please regenerate the enum to unmask."
			out << (htmlString)
			return
		} else {
			String sfldlId = httpSession.getAttribute(SecurityService.SFLDLID)
			if (sfldlId && tableNameEnum && columnEnum) {
				HashMap<String, SecuredFieldDescription> secColMap = httpSession.getAttribute(SecurityService.FIELD_LEVEL_SECURITY_MAP)

				if (secColMap!=null && !secColMap.containsKey(tableNameEnum)) {
					securityService.populateFieldLevelSecurity(sfldlId, httpSession, tableNameEnum)
					secColMap=httpSession.getAttribute(SecurityService.FIELD_LEVEL_SECURITY_MAP)
				}

				ArrayList<SecuredFieldDescription> secFieldDescList = secColMap.get(tableNameEnum)
				if (secFieldDescList) {
					for(SecuredFieldDescription secFieldDesc : secFieldDescList ) {
						if (secFieldDesc.securedFieldDetailEnum.cdoVarName()?.equals(attributeName)) {
							if (secFieldDesc.fieldAccessEnum.equals(FieldSecurityIndicatorEnum.PROHIBIT_CHANGE)) {
								isEditable = false
								break;
							} else if (secFieldDesc.fieldAccessEnum.equals(FieldSecurityIndicatorEnum.PROHIBIT_VIEW)){
								isViewable = false
								break;
							}
						}
					}
				}
			}
			if (!isEditable) {
				GregorianCalendar date = attrs.value
				SimpleDateFormat fmt = new SimpleDateFormat("MM/dd/yyyy");
				fmt.setCalendar(date);
				String dateFormatted
				if(date){
					dateFormatted = fmt.format(date.getTime());
					htmlString = dateFormatted
				}			
				out << htmlString
				return
			} else if (!isViewable) {
				out << htmlString
				return
			} else {
				out << g.datePicker(attrs)
				return
			}
		}
	}
	
	def securejqDatePicker = { attrs, body ->
		String tableName = attrs.tableName
		String attributeName = attrs.attributeName
		HttpSession httpSession = request.getSession()
		boolean isSecured = false
		boolean isEditable = true
		boolean isViewable = true
		String htmlString = "&nbsp;"
		FieldLevelSecurityTableEnum tableNameEnum = FieldLevelSecurityTableEnum.bytableName(tableName)
		String seColGroovyClassName = Util.dbNameToJavaName (tableName, true)+ "SecColDetailEnum"
		Class seColGroovyClass = null;
		def columnEnum = null;
		try {
			seColGroovyClass = securityService.getClass(seColGroovyClassName)
		} catch (Exception ex) {
			htmlString = "Unable to find the class com.dell.diamond.fms.sfldl.enums.${seColGroovyClassName} to fetch Field level security attributes. Check Table Name attribute in the tag."
			out << (htmlString)
			return
		}
		if (seColGroovyClass  ) {
			columnEnum = seColGroovyClass.bycdoVarName(attributeName)
		}
		if (columnEnum == null ||  columnEnum.mask() == null) {
			htmlString = " This field ${attributeName} is a masked field, invalid Configuration, please regenerate the enum to unmask."
			out << (htmlString)
			return
		} else {
			String sfldlId = httpSession.getAttribute(SecurityService.SFLDLID)
			if (sfldlId && tableNameEnum && columnEnum) {
				HashMap<String, SecuredFieldDescription> secColMap = httpSession.getAttribute(SecurityService.FIELD_LEVEL_SECURITY_MAP)

				if (secColMap!=null && !secColMap.containsKey(tableNameEnum)) {
					securityService.populateFieldLevelSecurity(sfldlId, httpSession, tableNameEnum)
					secColMap=httpSession.getAttribute(SecurityService.FIELD_LEVEL_SECURITY_MAP)
				}

				ArrayList<SecuredFieldDescription> secFieldDescList = secColMap.get(tableNameEnum)
				if (secFieldDescList) {
					for(SecuredFieldDescription secFieldDesc : secFieldDescList ) {
						if (secFieldDesc.securedFieldDetailEnum.cdoVarName()?.equals(attributeName)) {
							if (secFieldDesc.fieldAccessEnum.equals(FieldSecurityIndicatorEnum.PROHIBIT_CHANGE)) {
								isEditable = false
								break;
							} else if (secFieldDesc.fieldAccessEnum.equals(FieldSecurityIndicatorEnum.PROHIBIT_VIEW)){
								isViewable = false
								break;
							}
						}
					}
				}
			}
			if (!isEditable) {
				String dateFormatted = attrs.dateElementValue
				if(dateFormatted)
					htmlString = dateFormatted
				out << htmlString
				return
			} else if (!isViewable) {
				out << htmlString
				return
			} else {
				out << fmsui.jqDatePicker(attrs)
				return
			}
		}
	}
	
	/**
	 * This code is copied from securejqDatePicker
	 */
	def securejqDatePickerUIUX = { attrs, body ->
		String tableName = attrs.tableName
		String attributeName = attrs.attributeName
		HttpSession httpSession = request.getSession()
		boolean isSecured = false
		boolean isEditable = true
		boolean isViewable = true
		String htmlString = "&nbsp;"
		FieldLevelSecurityTableEnum tableNameEnum = FieldLevelSecurityTableEnum.bytableName(tableName)
		String seColGroovyClassName = Util.dbNameToJavaName (tableName, true)+ "SecColDetailEnum"
		Class seColGroovyClass = null;
		def columnEnum = null;
		try {
			seColGroovyClass = securityService.getClass(seColGroovyClassName)
		} catch (Exception ex) {
			htmlString = "Unable to find the class com.dell.diamond.fms.sfldl.enums.${seColGroovyClassName} to fetch Field level security attributes. Check Table Name attribute in the tag."
			out << (htmlString)
			return
		}
		if (seColGroovyClass  ) {
			columnEnum = seColGroovyClass.bycdoVarName(attributeName)
		}
		if (columnEnum == null ||  columnEnum.mask() == null) {
			htmlString = " This field ${attributeName} is a masked field, invalid Configuration, please regenerate the enum to unmask."
			out << (htmlString)
			return
		} else {
			String sfldlId = httpSession.getAttribute(SecurityService.SFLDLID)
			if (sfldlId && tableNameEnum && columnEnum) {
				HashMap<String, SecuredFieldDescription> secColMap = httpSession.getAttribute(SecurityService.FIELD_LEVEL_SECURITY_MAP)

				if (secColMap!=null && !secColMap.containsKey(tableNameEnum)) {
					securityService.populateFieldLevelSecurity(sfldlId, httpSession, tableNameEnum)
					secColMap=httpSession.getAttribute(SecurityService.FIELD_LEVEL_SECURITY_MAP)
				}

				ArrayList<SecuredFieldDescription> secFieldDescList = secColMap.get(tableNameEnum)
				if (secFieldDescList) {
					for(SecuredFieldDescription secFieldDesc : secFieldDescList ) {
						if (secFieldDesc.securedFieldDetailEnum.cdoVarName()?.equals(attributeName)) {
							if (secFieldDesc.fieldAccessEnum.equals(FieldSecurityIndicatorEnum.PROHIBIT_CHANGE)) {
								isEditable = false
								break;
							} else if (secFieldDesc.fieldAccessEnum.equals(FieldSecurityIndicatorEnum.PROHIBIT_VIEW)){
								isViewable = false
								break;
							}
						}
					}
				}
			}
			if (!isEditable) {
				String dateFormatted = attrs.dateElementValue
				if(dateFormatted)
					htmlString = dateFormatted
				out << htmlString
				return
			} else if (!isViewable) {
				out << htmlString
				return
			} else {
				out << fmsui.jqDatePickerUIUX(attrs)
				return
			}
		}
	}
}