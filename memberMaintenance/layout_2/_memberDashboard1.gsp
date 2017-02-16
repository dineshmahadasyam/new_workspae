<!DOCTYPE html>
<html>
<head>
<%@ page import="com.perotsystems.diamond.bom.FundsApplication"%>
<link rel="stylesheet"
	href="${resource(dir: '/css/dashboard', file: 'stylesheet.css')}"
	type="text/css" media="screen" />

<meta name="layout" content="main_2">

<g:set var="entityName"
	value="${message(code: 'memberMaster.label', default: 'MemberMaster')}" />
	
<g:set var="appContext" bean="grailsApplication"/>

<title>Dashboard</title>
<style>
BODY,INPUT,SELECT,TEXTAREA {
	/*font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif;*/
	font: 10pt Tahoma, arial, helvetica, sans-serif;
}
#eftConfigurationPeriod TD
{
	line-height: 1.4em;
	padding: 0em 0em;
	text-align: left;
	vertical-align: middle;
}

.fheader {
	cursor: default;
	unselectable: on;
	color: #FFFFFF;
	-moz-user-select: none;
	-webkit-user-select: none;
	-ms-user-select: none;
	user-select: none;
	height: 19px;
	text-align: left;
	background: rgb(0, 102, 204); /* Old browsers */
	/* IE9 SVG, needs conditional override of 'filter' to 'none' */
	background:
		url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iIzAwNjZjYyIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjI3JSIgc3RvcC1jb2xvcj0iIzI5ODlkOCIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjUyJSIgc3RvcC1jb2xvcj0iIzIwN2NjYSIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9Ijc4JSIgc3RvcC1jb2xvcj0iIzI5ODlkOCIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiM3ZGI5ZTgiIHN0b3Atb3BhY2l0eT0iMSIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);
	background: -moz-linear-gradient(top, rgba(0, 102, 204, 1) 0%,
		rgba(41, 137, 216, 1) 27%, rgba(32, 124, 202, 1) 52%,
		rgba(41, 137, 216, 1) 78%, rgba(125, 185, 232, 1) 100%); /* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, rgba(0,
		102, 204, 1)), color-stop(27%, rgba(41, 137, 216, 1)),
		color-stop(52%, rgba(32, 124, 202, 1)),
		color-stop(78%, rgba(41, 137, 216, 1)),
		color-stop(100%, rgba(125, 185, 232, 1))); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top, rgba(0, 102, 204, 1) 0%,
		rgba(41, 137, 216, 1) 27%, rgba(32, 124, 202, 1) 52%,
		rgba(41, 137, 216, 1) 78%, rgba(125, 185, 232, 1) 100%);
	/* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top, rgba(0, 102, 204, 1) 0%,
		rgba(41, 137, 216, 1) 27%, rgba(32, 124, 202, 1) 52%,
		rgba(41, 137, 216, 1) 78%, rgba(125, 185, 232, 1) 100%);
	/* Opera 11.10+ */
	background: -ms-linear-gradient(top, rgba(0, 102, 204, 1) 0%,
		rgba(41, 137, 216, 1) 27%, rgba(32, 124, 202, 1) 52%,
		rgba(41, 137, 216, 1) 78%, rgba(125, 185, 232, 1) 100%); /* IE10+ */
	background: linear-gradient(to bottom, rgba(0, 102, 204, 1) 0%,
		rgba(41, 137, 216, 1) 27%, rgba(32, 124, 202, 1) 52%,
		rgba(41, 137, 216, 1) 78%, rgba(125, 185, 232, 1) 100%); /* W3C */
	filter: progid:DXImageTransform.Microsoft.gradient(   startColorstr='#0066cc',
		endColorstr='#7db9e8', GradientType=0); /* IE6-8 */
	border-top-right-radius: 10px;
	border-top-left-radius: 10px;
}

.buttonClass {
	-moz-box-shadow:inset 0px 1px 0px 0px #b0b0b0;
	-webkit-box-shadow:inset 0px 1px 0px 0px #b0b0b0;
	box-shadow:inset 0px 1px 0px 0px #b0b0b0;
	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #e3e3e3), color-stop(1, #adadad) );
	background:-moz-linear-gradient( center top, #e3e3e3 5%, #adadad 100% );
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#e3e3e3', endColorstr='#adadad');
	background-color:#e3e3e3;
	-webkit-border-top-left-radius:10px;
	-moz-border-radius-topleft:10px;
	border-top-left-radius:10px;
	-webkit-border-top-right-radius:10px;
	-moz-border-radius-topright:10px;
	border-top-right-radius:10px;
	-webkit-border-bottom-right-radius:10px;
	-moz-border-radius-bottomright:10px;
	border-bottom-right-radius:10px;
	-webkit-border-bottom-left-radius:10px;
	-moz-border-radius-bottomleft:10px;
	border-bottom-left-radius:10px;
	text-indent:0px;
	border:2px solid #878787;
	display:inline-block;
	color:#000000;
	font-family:Arial;
	font-size:12px;
	font-weight:normal;
	font-style:normal;
	height:1em;
	line-height:1em;
	width:50px;
	padding-right:5px;
	padding-left:5px;
	text-decoration:none;
	text-align:center;
	cursor: pointer;

}
.buttonClass:hover {
	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #adadad), color-stop(1, #e3e3e3) );
	background:-moz-linear-gradient( center top, #adadad 5%, #e3e3e3 100% );
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#adadad', endColorstr='#e3e3e3');
	background-color:#adadad;
}.buttonClass:active {
	position:relative;
	top:1px;
}

table {
	cursor: default;
	unselectable: on;
	-moz-user-select: none;
	-webkit-user-select: none;
	-ms-user-select: none;
	user-select: none;
	border-collapse: collapse;
}

table tr {
	background-color: #fff;
	border-bottom: 1px #99b solid;
}

table tr:hover {
	background-color: #87CEEB;
}

tr:hover td {
	background-color: #87CEEB;
}

table td {
	display: table-cell;
	border-bottom: 1px #99b solid;
	padding: 0px;
	line-height: 1em;
	text-align: left;
	vertical-align: middle;
}


table td a {
	text-decoration: none;
	display: block;
	padding: 0px;
	height: 100%;
}
</style>
<script>
	function updateEFT(myTitle,eftType , effectiveDate, termDate, accountType) {
		var divObj = document.getElementById('eftConfigurationPeriod')
		loadEFTDetails(eftType, effectiveDate, termDate, accountType, null,	null)	;
		$.window({
			showModal : true,
			bookmarkable : false,
			minimizable : false,
			maximizable : false,
			width : 1200,
			height : 400,
			scrollable : true,
			modalOpacity : 0.5,
			title : myTitle,
			content : divObj.innerHTML 
		});
		
	}

function loadEFTDetails(eftType, startDate, endDate, accountType, accoutNumber,
			accountStatus) {
		showEFTConfiguration(eftType)
		document.getElementById("startDate_day").value = startDate_day
	    document.getElementById("startDate_month").value = startDate_day
	    document.getElementById("startDate_year").value = startDate_day
		document.getElementById("endDate_day").value = endDate_day
		document.getElementById("endDate_month").value = endDate_month
		document.getElementById("endDate_year").value = endDate_year
		
		document.getElementById("accountType").selectedIndex = accountType
		document.getElementById("accoutNumber").value = accoutNumber
		document.getElementById("confAccoutNumber").value = accoutNumber
		document.getElementById("accountStatus").value = accountStatus
	}

	function showEFTConfiguration(eftType) {
		document.getElementById("startDate_day").value = ""
	    document.getElementById("startDate_month").value = ""
	    document.getElementById("startDate_year").value = ""
		document.getElementById("endDate_day").value = ""
		document.getElementById("endDate_month").value = ""
		document.getElementById("endDate_year").value = ""
		
		document.getElementById("accountType").value = ""
		document.getElementById("accoutNumber").value = ""
		document.getElementById("confAccoutNumber").value = ""
		document.getElementById("accountStatus").value = ""

		if (eftType == "1") {
			document.getElementById("premimValue").style.display = "block";
			document.getElementById("dates").style.display = "none";
			document.getElementById("accountStatusDiv").style.display = "none";
			document.getElementById("saveButton").value = "Add One Time EFT Payment."
		} else if (eftType == "2") {
			document.getElementById("premimValue").style.display = "none";
			document.getElementById("dates").style.display = "block";
			document.getElementById("accountStatusDiv").style.display = "block";
			document.getElementById("saveButton").value = "Add Recurring EFT Payment."
		} else if (eftType == "3") {
			document.getElementById("premimValue").style.display = "none";
			document.getElementById("dates").style.display = "block";
			document.getElementById("accountStatusDiv").style.display = "block";
			document.getElementById("saveButton").value = "Update Recurring EFT Payment."
		}
	}
</script>

<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'jquery.window.css')}"
	type="text/css">

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
<script type="text/javascript">

/*$(document).ready(function() {
		
	});*/

	function expand(divTag, myTitle) {
		var divObj = document.getElementById(divTag)
		//$('img.enrollmentMaximize').click(function() {
			//	alert ("image clicked")
			$.window({
				showModal : true,
				bookmarkable : false,
				minimizable : false,
				maximizable : false,
				width : 1200,
				height : 400,
				scrollable : true,
				modalOpacity : 0.5,
				title : myTitle,
				content : divObj.innerHTML
			});
		//});
	}

	function loadNoticePDF(noticeId, subscriberId) {
		var appName = "${appContext.metadata['app.name']}";
		$.window({
			showModal : true,
			bookmarkable : false,
			minimizable : false,
			maximizable : true,
			width : 1200,
			height : 400,
			scrollable : true,
			modalOpacity : 0.5,
			title : "Notice Information",
			url: "/"+appName+"/memberMaintenance/renderNoticeAsPDF?noticeId=" + noticeId + "&subscriberId=" + subscriberId
		});
	}
	
	function loadInvoicePDF(invoiceId, subscriberId, issuerSubscriberId, currentMonthPremium, fedAPTCAmt, arAccountId, firstName, lastName, planCode, transfers, manualAdjustments, retroAdjustments, totalPremium, enrollmentStatus, otherPaymentAmount, otherPaymentAmount2) {
		var appName = "${appContext.metadata['app.name']}";
		$.window({
			showModal : true,
			bookmarkable : false,
			minimizable : false,
			maximizable : true,
			width : 1200,
			height : 400,
			scrollable : true,
			modalOpacity : 0.5,
			title : "Invoice Information",
			url: "/"+appName+"/memberMaintenance/renderInvoiceAsPDF?invoiceId=" + invoiceId + "&subscriberId="+subscriberId + "&issuerSubscriberId="+issuerSubscriberId +"&fedAPTCAmt="+fedAPTCAmt +"&arAccountId="+arAccountId+"&firstName="+firstName+"&lastName="+lastName+"&planCode="+planCode+"&transfers="+transfers+"&manualAdjustments="+manualAdjustments+"&retroAdjustments="+retroAdjustments+"&totalPremium="+totalPremium+"&enrollmentStatus="+enrollmentStatus+"&otherPaymentAmount="+otherPaymentAmount+"&otherPaymentAmount2="+otherPaymentAmount2
		});
	}

	//Multiplan - Load Invoice Details Screen
	function loadInvoiceDetails(invoiceId, subscriberId, issuerSubscriberId, arAccountId) {
		var appName = "${appContext.metadata['app.name']}";
		$.window({
			showModal : true,
			bookmarkable : false,
			minimizable : false,
			maximizable : false,
			width : 300,
			height : 400,
			scrollable : true,
			modalOpacity : 0.5,
			title : "Invoice Detail",
			url: "/"+appName+"/memberMaintenance/getInvoiceDetails?invoiceId=" + invoiceId + "&subscriberId="+subscriberId + "&issuerSubscriberId="+issuerSubscriberId + "&arAccountId="+arAccountId
		});
	}

	//Multiplan - Load Quote Details Screen
	function loadQuoteDetails(subscriberId) {
		var appName = "${appContext.metadata['app.name']}";
		$.window({
			showModal : true,
			bookmarkable : false,
			minimizable : false,
			maximizable : false,
			width : 1200,
			height : 400,
			scrollable : true,
			modalOpacity : 0.5,
			title : "Quote Detail",
			url: "/"+appName+"/memberMaintenance/getQuoteDetails?subscriberId="+subscriberId
		});
	}
	

	function checkRedirect(loggedInId) {
		var appName = "${appContext.metadata['app.name']}";
		var hiddenObj = document.getElementById(loggedInId)
		var loggedIn = hiddenObj.value
		//alert(loggedIn)
		if (loggedIn == "false") {
			window.location.assign('/"+appName+"/login')
		}
	}

	function checkLoggedIn(accessURI) {
		var appName = "${appContext.metadata['app.name']}";
		var loggedInUser;
		var loginRequest = jQuery.ajax({
			url : "/"+appName+"/login/ajaxGetLoggedInUserName",
			type : "POST",
			success : function(result) {
				// alert (result)
				if (result == "null") {
					window.location.assign('/"+appName+"/login')
				}
			}
		});
		var authorizeRequest = jQuery.ajax({
			url : "/"+appName+"/login/ajaxAuthorizeUser?uri="+accessURI,
			type : "POST",
			success : function(result) {
				// alert (result)
				if (result == "false") {
					alert ("You do not have permission to update this content");
					return false;
					//window.location.assign('/"+appName+"/login')
				}
			}
		});		
	}
</script>

<script type="text/javascript">

/*$(document).ready(function() {
		
	});*/

	function expand(divTag, myTitle) {
		var divObj = document.getElementById(divTag)
		//$('img.enrollmentMaximize').click(function() {
			//	alert ("image clicked")
			$.window({
				showModal : true,
				bookmarkable : false,
				minimizable : false,
				maximizable : false,
				width : 1200,
				height : 400,
				scrollable : true,
				modalOpacity : 0.5,
				title : myTitle,
				content : divObj.innerHTML
			});
		//});
	}

	function payByPhone(subscriberId, currentAccountBalance, arAccountId) {
		var appName = "${appContext.metadata['app.name']}";
		$.window({
			showModal : true,
			bookmarkable : false,
			minimizable : false,
			maximizable : false,
			width : 800,
			height : 500,
			scrollable : true,
			modalOpacity : 0.5,
			title : "Payment Gateway",
			url: "/"+appName+"/memberMaintenance/payByPhone?subscriberId=" + subscriberId + "&currentAccountBalance="+currentAccountBalance+ "&arAccountId="+arAccountId
		});
	}

	function checkRedirect(loggedInId) {
		var appName = "${appContext.metadata['app.name']}";
		var hiddenObj = document.getElementById(loggedInId)
		var loggedIn = hiddenObj.value
		//alert(loggedIn)
		if (loggedIn == "false") {
			window.location.assign('/"+appName+"/login')
		}
	}

	function checkLoggedIn(accessURI) {
		var appName = "${appContext.metadata['app.name']}";
		var loggedInUser;
		var loginRequest = jQuery.ajax({
			url : "/"+appName+"/login/ajaxGetLoggedInUserName",
			type : "POST",
			success : function(result) {
				// alert (result)
				if (result == "null") {
					window.location.assign('/"+appName+"/login')
				}
			}
		});
		var authorizeRequest = jQuery.ajax({
			url : "/"+appName+"/login/ajaxAuthorizeUser?uri="+accessURI,
			type : "POST",
			success : function(result) {
				// alert (result)
				if (result == "false") {
					alert ("You do not have permission to update this content");
					return false;
					//window.location.assign('/"+appName+"/login')
				}
			}
		});		
	}
</script>
<script type="text/javascript">
	function confirmDialog(subscriberId, seqSubsEftInfoId) {
	    // Define the Dialog and its properties.
	    $("#dialog-confirm").dialog({
	        resizable: false,
	        modal: true,
	        height: 250,
	        width: 400,
	        buttons: {
	            'No': function () {
	           		$(this).dialog('close');
	           		confirmCallback(false);
	           		$(this).dialog('destroy')
	            },
	            'Yes': function () {
	                $(this).dialog('close');
	                confirmCallback(true, subscriberId, seqSubsEftInfoId);
	                $(this).dialog('destroy')
	            }
	            
	        }
	    });
	}
	
	function confirmCallback(value, subscriberId, seqSubsEftInfoId) {
		var appName = "${appContext.metadata['app.name']}";
	    if (value) {
	       // alert("Confirmed");
	    	var paymentVoidRequest = jQuery.ajax({
				url : "/"+appName+"/memberMaintenance/ajaxVoidPayment",
				type : "POST",
				data : {subscriberId:subscriberId, seqSubsEftInfoId:seqSubsEftInfoId},
				success : function() {
					location.reload();
				}
			});	
			
	    } else {
	       // alert("Rejected");
	    }
	}
</script>

</head>

<body onLoad="showEFTConfiguration()">
<div id="dialog-confirm" title="Void Payment" style="display:none">Are you Sure?</div>
	<g:if test="${flash.message}">
		<div class="message" role="status">
			${flash.message}
		</div>
	</g:if>
	<br>
	<div id="pageContent" style="width:100%; overflow-x:scroll;">
			<g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshMemberNotes">		
			<div id="protletFullWidthColumn">
				<div id="dealsByStage3" class="portletFullWidth" >
					<div style="float: left; width:1262px;">					
						<div class="fheader">
							&nbsp;&nbsp;Notes &nbsp;&nbsp;
							<g:remoteLink action="ajaxRefreshMemberNotes"
								params="${[subscriberId :params.subscriberId ]}" oncomplete="showSpinner(false);" before="checkLoggedIn('/memberMaintenance/ajaxRefreshMemberNotes')" 
								onloading="showSpinner(true);" update="memberNotesTable">
								<img width="15" height="15" src="${resource(dir: 'images', file: 'refresh.png')}" onmouseover="this.src='${resource(dir: 'images', file: 'refresh_hover.png')}'" onmouseout="this.src='${resource(dir: 'images', file: 'refresh.png')}'">
							</g:remoteLink>
							&nbsp; <img
								onclick="expand('memberNotesTable', 'Representative Notes')" width="15" height="15"
								src="${resource(dir: 'images', file: 'expand-icon3.png')}">
								<g:checkURIAuthorization uri="/memberMaintenance/ajaxCreateNote">	
											<g:hiddenField id="ajaxSubscriberId" name="ajaxSubscriberId" value="${params.subscriberId}" />						
											<g:remoteLink action="ajaxCreateNote" class="buttonClass" style=" width:100px; height:17px; margin-left: 5px; display:inline"
												params="${[subscriberId :params.subscriberId]}" oncomplete="showSpinner(false);" before="checkLoggedIn('/memberMaintenance/ajaxCreateNote')" 
												onloading="showSpinner(true);" update="memberNotesTable">Create New Note</g:remoteLink>

								</g:checkURIAuthorization>
						</div>
					</div>
					<div class="" style="width: 1260px; float: left;">
						<div
							style="width:1260px; height:200px; border: 1px solid #CBCBCB; overflow:scroll;"
							class="portletContent">
							<div style="width: 100%; float: left;" id="memberNotesTable">
								<g:render template="dashboard/memberNotes" model="[memberMasterList: memberMasterList]" />
								<br>
								<br>
							</div>						
							</div>
					</div>
				</div>
			</div>
		</g:checkURIAuthorization>
		<g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshMemberEnrollment">
			<div id="portletColumn1">
				<div id="dealsByStage1" class="portletLarge">
					<div style="float:left; width:462px;">
						<div class="fheader">
							&nbsp;&nbsp;Member Information&nbsp;&nbsp;
							<g:remoteLink action="ajaxRefreshMemberEnrollment"
								params="${[subscriberId :params.subscriberId ]}" oncomplete="showSpinner(false);" before="checkLoggedIn('/memberMaintenance/ajaxRefreshMemberEnrollment')" 
								onloading="showSpinner(false);" update="memberEnrollmentTableDiv">
								<img width="15" height="15" src="${resource(dir: 'images', file: 'refresh.png')}" onmouseover="this.src='${resource(dir: 'images', file: 'refresh_hover.png')}'" onmouseout="this.src='${resource(dir: 'images', file: 'refresh.png')}'">
							</g:remoteLink>
							&nbsp; <img
								onclick="expand('memberEnrollmentTableDiv', 'Member Enrollment Information')" width="15" height="15"
								src="${resource(dir: 'images', file: 'expand-icon3.png')}">
						</div>
					</div>
					<div class="" style="width: 100%; float: left;">
						<div
							style="width: 100%; height: 255px; border: 1px solid #CBCBCB; overflow-x:scroll;"
							class="portletContentScroll">
							<div style="width: 100%; float: left;" id="memberEnrollmentTableDiv">
								<div id='Overall_risk_index_div'></div>							
									<g:render template="dashboard/memberEnrollment" model="[memberMasterList: memberMasterList]" />
							</div>
						</div>
					</div>
				</div>
			</div>
			</g:checkURIAuthorization>
		<g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshMemberEligibility">
			<div id="protletHalfWidthColumn" >
				<div id="memberEligHistoryList" class="portletHalfWidth">
					<div style="float: left; width:782px;">
						<div class="fheader">
							&nbsp;&nbsp;Current Eligibility History&nbsp;&nbsp;
							<g:remoteLink action="ajaxRefreshMemberEligibility"
								params="${[subscriberId :params.subscriberId, billingInformation: billingInformation]}" oncomplete="showSpinner(false);" before="checkLoggedIn('/memberMaintenance/ajaxRefreshMemberEligibility')" 
								onloading="showSpinner(true);" update="memberEligibilityTable">
								<img width="15"
									height="15" src="${resource(dir: 'images', file: 'refresh.png')}" onmouseover="this.src='${resource(dir: 'images', file: 'refresh_hover.png')}'" onmouseout="this.src='${resource(dir: 'images', file: 'refresh.png')}'">							
							</g:remoteLink>
							&nbsp; <img
								onclick="expand('memberEligibilityTable', 'Member\'s Current Eligibility')" width="15" height="15"
								src="${resource(dir: 'images', file: 'expand-icon3.png')}">
						</div>
					</div>
					<div class="" style="width: 780px; float: left;">
						<div
							style="width: 100%; height: 255px; border: 1px solid #CBCBCB; overflow-x:scroll;"
							class="portletContent">
							<div style="width: 100%; float: left;" id="memberEligibilityTable">
								<div id='Overall_risk_index_div'></div>
									<g:render template="dashboard/memberEligibility" model="[memberMasterList: memberMasterList, billingInformation: billingInformation]" />
								</div>
						</div>
					</div>
				</div>
			</div>
		</g:checkURIAuthorization>
		<g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshMemberDemographics">
			<div id="protletHalfWidthColumn">
				<div id="dealsByStage3" class="portletHalfWidth">
					<div style="float: left;  width:782px;">
						<div class="fheader">
							&nbsp;&nbsp;Member Address Information&nbsp;&nbsp;
							<g:remoteLink action="ajaxRefreshMemberDemographics"
								params="${[subscriberId :params.subscriberId]}" oncomplete="showSpinner(false);" before="checkLoggedIn('/memberMaintenance/ajaxRefreshMemberDemographics')" 
								onloading="showSpinner(true);" update="memberDemographicsTable">
							<img width="15" height="15" src="${resource(dir: 'images', file: 'refresh.png')}" onmouseover="this.src='${resource(dir: 'images', file: 'refresh_hover.png')}'" onmouseout="this.src='${resource(dir: 'images', file: 'refresh.png')}'">
							</g:remoteLink>
							&nbsp; <img
								onclick="expand('memberDemographicsTable', 'Member\'s Current Demographics')" width="15" height="15"
								src="${resource(dir: 'images', file: 'expand-icon3.png')}">
						</div>
					</div>
					<div class="" style="width: 780px; float: left;">
						<div
							style="width: 100%; height: 255px; border: 1px solid #CBCBCB; overflow-x:scroll;"
							class="portletContent">
							<div id="memberDemographicsTable">							
								<div id='Overall_risk_index_div'></div>
								<g:render template="dashboard/memberDemographics" model="[memberMasterList: memberMasterList]" />
							</div>
		
						</div>
					</div>
				</div>
			</div>
		</g:checkURIAuthorization>
		<g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshMemberBillInfo">		
			<div id="portletColumn1">
				<div id="dealsByStage1" class="portletLarge">
					<div style="float: left; height:280px; width:462px;">
						<div class="fheader">
							&nbsp;&nbsp;Account Information &nbsp;&nbsp;
								<g:remoteLink action="ajaxRefreshMemberBillInfo"
									params="${[subscriberId :params.subscriberId ]}" oncomplete="showSpinner(false);" before="checkLoggedIn('/memberMaintenance/ajaxRefreshMemberBillInfo')" 
									onloading="showSpinner(true);" update="billInfoTable">
								<img width="15"
									height="15" src="${resource(dir: 'images', file: 'refresh.png')}" onmouseover="this.src='${resource(dir: 'images', file: 'refresh_hover.png')}'" onmouseout="this.src='${resource(dir: 'images', file: 'refresh.png')}'">
							</g:remoteLink>
							&nbsp; <img
									onclick="expand('billInfoTable', 'Account Information')" width="15" height="15"
									src="${resource(dir: 'images', file: 'expand-icon3.png')}">
						</div>
					<div class="" style="width: 100%; float: left;">
						<div style="width: 100%; height: 255px; border: 1px solid #CBCBCB; overflow-x:scroll;" class="portletContentScroll">
							<div style="width: 100%; float: left;" id="memberEnrollmentTableDiv">
								<div id='Overall_risk_index_div'></div>
								<g:render template="dashboard/billingInformation" model="[memberMasterList: memberMasterList]" />
								<div ${billingInformation?.latestInvoiceId ? 'style="display:block"' :'style="display:none"'}>
								<g:if test="${clientName.equals('1Z2RK')}">
									<g:checkURIAuthorization uri="/memberMaintenance/ajaxInvoice">
										<div class="buttonClass" style="width:100px; margin-left: 5px; display:inline" onclick="loadInvoicePDF('${billingInformation?.latestInvoiceId}','${ params.subscriberId }','${billingInformation?.fmsInvoiceList[0]?.eligHistory?.issuerSubscriberId}','${ billingInformation?.currentMonthPremium }','${ billingInformation?.fedAPTCAmt }','${billingInformation?.arAccountId }','${billingInformation?.billableEntityInfo?.firstName}','${billingInformation?.billableEntityInfo.lastName}','${billingInformation?.fmsInvoiceList[0]?.eligHistory?.planCode}','${billingInformation?.fmsInvoiceList[0]?.transfers}','${billingInformation?.fmsInvoiceList[0]?.manualAdjustments}','${billingInformation?.fmsInvoiceList[0]?.retroAdjustments}','${billingInformation?.fmsInvoiceList[0]?.currentMonthPremium}','${arAccount?.enrollmentStatus}','${ billingInformation?.otherPaymentAmount}','${ billingInformation?.otherPaymentAmount2}')"> 
											&nbsp;View Current Bill&nbsp;</div>
									</g:checkURIAuthorization>
								</g:if>
								<%--Removed via 58133<g:checkURIAuthorization uri="/memberMaintenance/ajaxDuplicateInvoice">						
									<g:remoteLink action="ajaxDuplicateInvoice" class="buttonClass" style=" width:100px; margin-left: 5px; display:inline"
										params="${[subscriberId :params.subscriberId, invoiceId: billingInformation?.latestInvoiceId]}" oncomplete="showSpinner(false);" before="checkLoggedIn('/memberMaintenance/ajaxRefreshMemberBillInfo')" 
										onloading="showSpinner(true);" update="billInfoTable">Request Duplicate</g:remoteLink>
									</g:checkURIAuthorization>--%>
								<g:if test="${clientName.equals('1Z2RK')}">
									<g:checkURIAuthorization uri="/memberMaintenance/payByPhone">
										<div class="buttonClass" style="width:100px; margin-left: 5px; display:inline" onclick="payByPhone('${params.subscriberId}', '${ billingInformation?.currentAccountBalance }', '${ billingInformation?.arAccountId}')"> 
											&nbsp;Pay Bill&nbsp;</div>
									</g:checkURIAuthorization>
								</g:if>
								</div>
							</div>
						</div>	
					</div>
				</div>
			</div>
		</div>
		</g:checkURIAuthorization>
		
		<g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshMemberBillHist">		
			<div id="protletFullWidthColumn">
				<div id="dealsByStage3" class="portletFullWidth" >
					<div style="float: left; width:1262px;">					
						<div class="fheader">
							&nbsp;&nbsp;Billing History &nbsp;&nbsp;
							<g:remoteLink action="ajaxRefreshMemberBillHist"
								params="${[subscriberId :params.subscriberId, showAllInvoices: params.showAllInvoices ]}" oncomplete="showSpinner(false);" before="checkLoggedIn('/memberMaintenance/ajaxRefreshMemberBillHist')" 
								onloading="showSpinner(true);" update="memberBillHistTable">
								<img width="15" height="15" src="${resource(dir: 'images', file: 'refresh.png')}" onmouseover="this.src='${resource(dir: 'images', file: 'refresh_hover.png')}'" onmouseout="this.src='${resource(dir: 'images', file: 'refresh.png')}'">
							</g:remoteLink>
							&nbsp; <img
								onclick="expand('memberBillHistTable', 'Billing History')" width="15" height="15"
								src="${resource(dir: 'images', file: 'expand-icon3.png')}">
						</div>
					</div>
					<div class="" style="width: 1260px; float: left;">
					<%def billHistoryHeight = (((billingInformation?.fmsInvoiceList ? billingInformation?.fmsInvoiceList?.size() :1 ) ) *25)+ 200 %>
						<div style="width:1260px; height:${billHistoryHeight}px; border: 1px solid #CBCBCB; overflow-x:scroll;" class="portletContent">
							<div style="width: 100%; float: left;" id="memberBillHistTable">
								<g:render template="dashboard/billingHistory" model="[memberMasterList: memberMasterList]" />
						</div>	
						<g:if test="${params.showAllInvoices == null}">
									<div class="buttonClass" style="width:130px; margin-left: 5px; display:inline" 
									onclick="window.location.assign('/${appContext.metadata['app.name']}/memberMaintenance/memberDashboard1?subscriberId=${params.subscriberId}&showAllInvoices=true')"> 
									&nbsp;&nbsp;Show All Invoices&nbsp;&nbsp;</div>					
						</g:if>
						<br>
						<br>					
						</div>
					</div>
				</div>
			</div>
		</g:checkURIAuthorization>
		<g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshEftSubscription">	
			<div id="protletHalfWidthColumn" >
				<div id="memberEligHistoryList" class="portletHalfWidth">
					<div style="float: left; width:782px;">
						<div class="fheader">
							&nbsp;&nbsp;EFT Subscription Information&nbsp;&nbsp;
							<g:remoteLink action="ajaxRefreshEftSubscription"
								params="${[eftConfigPeriodId : eftSubscriptionItem?.eftConfigPeriodId, seqSubsId: eftSubscriptionCommand.seqSubsId, seqGroupId: eftSubscriptionCommand.seqGroupId, arAccountId: eftSubscriptionCommand.arAccountId]}" oncomplete="showSpinner(false);" before="checkLoggedIn('/memberMaintenance/ajaxRefreshEftSubscription')" 
								onloading="showSpinner(true);" update="eftSubscriptionTable">
								<img width="15"
									height="15" src="${resource(dir: 'images', file: 'refresh.png')}" onmouseover="this.src='${resource(dir: 'images', file: 'refresh_hover.png')}'" onmouseout="this.src='${resource(dir: 'images', file: 'refresh.png')}'">							
							</g:remoteLink>
							&nbsp; <img
								onclick="expand('eftSubscriptionTable', 'EFT Subscription Information')" width="15" height="15"
								src="${resource(dir: 'images', file: 'expand-icon3.png')}">
						</div>
					</div>
					<div class="" style="width: 780px; float: left;">
						<div
							style="width: 100%; height: 255px; border: 1px solid #CBCBCB; overflow-x:scroll;"
							class="portletContent">
							<div style="width: 100%; float: left;" id="eftSubscriptionTable">
								<div id='Overall_risk_index_div'></div>
									<g:render template="dashboard/eftSubscription" model="[eftSubscriptionCommand: eftSubscriptionCommand]" />
								</div>
						</div>
					</div>
				</div>
			</div>	
		</g:checkURIAuthorization>
		<g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshMemberPayHist">		
			<div id="protletFullWidthColumn">
				<div id="dealsByStage3" class="portletFullWidth">
					<div style="width: 1262px; float: left;">
						<%-- span class="leftCorner" style="float: left"></span> <span
							class="portletHeader" style="float: left"><h4>Payment
								Information</h4></span> <span class="rightCorner" style="float: left"></span--%>
						<div class="fheader">
							&nbsp;&nbsp;Payment Information &nbsp;&nbsp;
							<g:remoteLink action="ajaxRefreshMemberPayHist"
								params="${[subscriberId :params.subscriberId ]}" oncomplete="showSpinner(false);" before="checkLoggedIn('/memberMaintenance/ajaxRefreshMemberPayHist')" 
								onloading="showSpinner(true);" update="memberPaymentInfoTable">
							<img width="15"
								height="15" src="${resource(dir: 'images', file: 'refresh.png')}" onmouseover="this.src='${resource(dir: 'images', file: 'refresh_hover.png')}'" onmouseout="this.src='${resource(dir: 'images', file: 'refresh.png')}'">
							</g:remoteLink>
							&nbsp; <img
								onclick="expand('paymentInfoTable',  'PaymentInformation')" width="15" height="15"
								src="${resource(dir: 'images', file: 'expand-icon3.png')}">
						</div>
					</div>
					<div class="" style="width: 1260px; float: left;">
						<div
							style="width: 1260px; border: 1px solid #CBCBCB;"
							class="portletContent" id="memberPaymentInfoTable">
								<g:render template="dashboard/paymentInformation" model="[memberMasterList: memberMasterList]" />
							<br>
							<div id="eftConfigurationPeriod" style="display:none"
								style="border: 1px solid #CBCBCB;">
								<h4
									style="font-weight: inherit; width: 100%; background: #EFEFEF; color: #666666"><div class="fheader">&nbsp;&nbsp;Bank
									Account Information</div></h4>
								<form name="eftForm">
									<%-- input type="radio" name="eftType" value="1"
										onChange="showEFTConfiguration()"
										onClick="showEFTConfiguration()"><span
										style="font: 9px verdana;"> One Time EFT</span> <input
										type="radio" name="eftType" value="2" checked="checked"
										onChange="showEFTConfiguration()"
										onClick="showEFTConfiguration()" id="recurring"><span
										style="font: 9px verdana;"> Recurring EFT</span --%>
									<table style="table-layout: fixed; width: 100%;" border="0">
										
										<th colspan="4">
											
										</th>
									</tr-->
										<tr
											style="white-space: nowrap; border-bottom: 0px; vertical-align: middle;">
											<td
												style="white-space: nowrap; border-bottom: 0px; vertical-align: middle;"
												colspan="2">
												<div id="premimValue" style="display: none">
													<table style="table-layout: fixed; width: 100%" border="0">
														<tr style="border-bottom: 0px;">
															<td  class="listingColumn" 
																style="white-space: nowrap; border-bottom: 0px; vertical-align: middle;">Pay
																Current Amount :</td>
															<td style="border-bottom: 0px; vertical-align: middle;"><g:formatNumber number="${billingInformation?.currentAccountBalance }" format="\$###,##0.00" />
															<div style="display:${billingInformation?.currentAccountBalance > 0?'none':'inline' }">  (No Payment required)</div>
															</td>
														</tr>
														<tr style="border-bottom: 0px;">
															<td  class="listingColumn" 
																style="white-space: nowrap; border-bottom: 0px; vertical-align: middle;">Payment
																Amount :</td>
															<td  class="listingColumn" style="border-bottom: 0px; vertical-align: middle;"><input
																type="text" id="paymentAmount" value="" /></td>
														</tr>
													</table>
												</div>
											</td>
										</tr>
										<tr style="border-bottom: 0px;">
											<td  class="listingColumn" 
												style="white-space: nowrap; border-bottom: 0px; vertical-align: middle;"
												colspan="2">
												<div id="dates" style="display: none">
													<table style="table-layout: fixed; width: 100%" border="0">
														<tr style="border-bottom: 0px;">
															<td  class="listingColumn" 
																style="white-space: nowrap; border-bottom: 0px; vertical-align: middle;">Start
																Date :</td>
															<td   class="listingColumn" style="border-bottom: 0px; vertical-align: middle;">
															
																  <g:datePicker name="startDate" 
													                       id="startDate"
													                       precision="day" 
													                       value="${params.startDate}" 
												                       	   noSelection="['':'']" 
													                       relativeYears="[-100..5]" 
													                       default="none"/>		
																
																</td>
														</tr>
														<tr style="border-bottom: 0px;">
															<td  class="listingColumn" 
																style="white-space: nowrap; border-bottom: 0px; vertical-align: middle;">End
																Date :</td>
															<td style="border-bottom: 0px; vertical-align: middle;">  <g:datePicker name="endDate" 
													                       id="endDate"
													                       precision="day" 
													                       value="${params.endDate}" 
												                       	   noSelection="['':'']" 
													                       relativeYears="[-100..5]" 
													                       default="none"/>		</td>
														</tr>
													</table>
												</div>
											</td>
										</tr>
										<tr style="border-bottom: 0px; vertical-align: middle;">
											<td  class="listingColumn" 
												style="white-space: nowrap; border-bottom: 0px; vertical-align: middle;">Account
												Type :</td>
											<td   class="listingColumn" style="border-bottom: 0px; vertical-align: middle;">
												<span style="font: 14px verdana;"><select
													style="width: 150px" id="accountType">
														<option value="">--Select Account Type --</option>
														<option value="checking">Checking</option>
														<option value="saving">Saving</option>
												</select></span> <%-- input type="text" id="accountType" value="" /> --%>
											</td>
										</tr>
										<tr style="border-bottom: 0px; vertical-align: middle;">
											<td  class="listingColumn" 
												style="white-space: nowrap; border-bottom: 0px; vertical-align: middle;">Routing
												Number :</td>
											<td  class="listingColumn" style="border-bottom: 0px; vertical-align: middle;"><input
												type="text" id="accoutNumber" value="" /></td>
										</tr>
										<tr style="border-bottom: 0px; vertical-align: middle;">
											<td  class="listingColumn" 
												style="white-space: nowrap; border-bottom: 0px; vertical-align: middle;">Account
												Number :</td>
											<td  class="listingColumn" style="border-bottom: 0px; vertical-align: middle;"><input
												type="text" id="accoutNumber" value="" /></td>
										</tr>
										<tr style="border-bottom: 0px; vertical-align: middle;">
											<td class="listingColumn" 
												style="white-space: nowrap; border-bottom: 0px; vertical-align: middle;">Confirm
												Account Number :</td>
											<td style="border-bottom: 0px; vertical-align: middle;"><input
												type="text" id="confAccoutNumber" value="" /></td>
										</tr>
										<tr style="border-bottom: 0px;">
											<td class="listingColumn" 
												style="white-space: nowrap; border-bottom: 0px; vertical-align: middle;"
												colspan="2">
												<div id="accountStatusDiv" style="display: none">
													<table style="table-layout: fixed; width: 100%" border="0">
														<tr
															style="white-space: nowrap; border-bottom: 0px; vertical-align: middle;">
															<td class="listingColumn" 
																style="white-space: nowrap; border-bottom: 0px; vertical-align: middle;">Account
																Status :</td>
															<td style="border-bottom: 0px; vertical-align: middle;"><input
																type="text" id="accountStatus" value=""
																disabled="disabled" /></td>
														</tr>
													</table>
												</div>
											</td>
										</tr>
									</table>
                                    <span style="width: 100%; text-align: center; margin-left: 25%"><input
										id="saveButton" type="button" name="saveEFTConfigPeriod"
										value="Add/Update Payment" /></span>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
			</g:checkURIAuthorization>
			
			<%-- Start Notice --%>
			<g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshMemberNotice">		
			<div id="protletFullWidthColumn">
				<div id="dealsByStage3" class="portletFullWidth" >
					<div style="float: left; width:1262px;">					
						<div class="fheader">
							&nbsp;&nbsp;Notices &nbsp;&nbsp;
							<g:remoteLink action="ajaxRefreshMemberNotice"
								params="${[subscriberId :params.subscriberId ]}" oncomplete="showSpinner(false);" 
								before="checkLoggedIn('/memberMaintenance/ajaxRefreshMemberNotice')" 
								onloading="showSpinner(true);" update="memberNoticeTable">
								<img width="15" height="15" src="${resource(dir: 'images', file: 'refresh.png')}" 
									onmouseover="this.src='${resource(dir: 'images', file: 'refresh_hover.png')}'" 
									onmouseout="this.src='${resource(dir: 'images', file: 'refresh.png')}'">
							</g:remoteLink>
							&nbsp; <img
								onclick="expand('memberNoticeTable', 'Notices')" width="15" height="15"
								src="${resource(dir: 'images', file: 'expand-icon3.png')}">
						</div>
					</div>
					<div class="" style="width: 1260px; float: left;">
					<%
						def noticesHeight = (((notices ? notices.size() :1 ) ) *25)+ 200
						 %>
						<div
							style="width:1260px; height:${noticesHeight}px; border: 1px solid #CBCBCB; overflow-x:scroll;"
							class="portletContent">
							<div style="width: 100%; float: left;" id="memberNoticeTable">
								<g:render template="dashboard/memberNotices" model="[notices: notices]" />
								<g:if test="${params.showAllNotices == null}">
									<div class="buttonClass" style="width:130px; margin-left: 5px; display:inline" 
									onclick="window.location.assign('/${appContext.metadata['app.name']}/memberMaintenance/memberDashboard1?subscriberId=${params.subscriberId}&showAllNotices=true')"> 
									&nbsp;&nbsp;Show All Notices&nbsp;&nbsp;</div>					
								</g:if>
								<br>
								<br>
							</div>						
							</div>
					</div>
				</div>
			</div>
		</g:checkURIAuthorization>
			<!--End Notice  -->

		<%-- Start EFT Payment --%>
		<g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshEftPaymentDetails">
			<div id="protletFullWidthColumn">
				<div id="dealsByStage3" class="portletFullWidth">
					<div style="float: left; width: 1262px;">
						<div class="fheader">&nbsp;&nbsp;EFT Payment Details &nbsp;&nbsp;
							<g:remoteLink action="ajaxRefreshEftPaymentDetails" params="${[subscriberId :params.subscriberId ]}"	
								oncomplete="showSpinner(false);" before="checkLoggedIn('/memberMaintenance/ajaxRefreshEftPaymentDetails')"
								onloading="showSpinner(true);" update="eftSubscriberPaymentTable">
									<img width="15" height="15"	src="${resource(dir: 'images', file: 'refresh.png')}"
									onmouseover="this.src='${resource(dir: 'images', file: 'refresh_hover.png')}'"
									onmouseout="this.src='${resource(dir: 'images', file: 'refresh.png')}'">
							</g:remoteLink>
							&nbsp; <img onclick="expand('eftSubscriberPaymentTable', 'EftSubscriberPayment')" width="15" height="15" src="${resource(dir: 'images', file: 'expand-icon3.png')}">
						</div>
					</div>
					<div class="" style="width: 1260px; float: left;">
						<div style="width:1260px; border: 1px solid #CBCBCB; overflow-x:scroll;" class="portletContent">
							<div style="width: 100%; float: left;" id="eftSubscriberPaymentTable">
								<g:render template="dashboard/eftSubscriberPayment" model="[eftPaymentDetails: eftPaymentDetails]" />
							</div>
						</div>
					</div>
				</div>
			</div>
		</g:checkURIAuthorization>
		<!-- End EFT Payment -->

	</div>
</body>
</html>
