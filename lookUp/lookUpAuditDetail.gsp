<!-- UI Selector - fms.ui.theme.selector value is in messages.properties -->
<!-- UI Selector - fmsUIThemeSelector value is in myEnv.properties -->

<%@ page import="com.dell.diamond.FMSAdminConstants" %>

<g:if test="${grailsApplication.config.fms.ui.theme.selector.equals(FMSAdminConstants.FMS_UI_THEME_SELECTOR_1) || grailsApplication.config.fms.ui.theme.selector.equals(FMSAdminConstants.FMS_UI_THEME_SELECTOR_2)}">
	<g:render template="../lookUp/layout_${grailsApplication.config.fms.ui.theme.selector}/lookUpAuditDetail" />
</g:if>
<g:else>
	<g:render template="../lookUp/layout_2/lookUpAuditDetail"/>
</g:else>