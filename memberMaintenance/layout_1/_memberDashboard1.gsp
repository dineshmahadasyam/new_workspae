<head>
	<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'memberDashboard.label', default: 'Dashboard')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
	<g:set var="appContext" bean="grailsApplication"/>
	
	<!-- Main menu select -->
	<meta name="navSelector" content="maint"/>
	<!-- Child menu select -->
	<meta name="navChildSelector" content="memberMaintenance"/>
	
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.window.css')}" type="text/css">
	
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>

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
	
	<script type="text/javascript">
	var appName = "${appContext.metadata['app.name']}";
	
	function loadNoticePDF(noticeId, subscriberId) {
		var urlToLoad =  "/"+appName+"/memberMaintenance/renderNoticeAsPDF?noticeId=" + noticeId + "&subscriberId=" + subscriberId;
		openModalWindow (urlToLoad, null,false);
	}
	
	function loadInvoicePDF(invoiceId, subscriberId, issuerSubscriberId, currentMonthPremium, fedAPTCAmt, arAccountId, firstName, lastName, planCode, transfers, manualAdjustments, retroAdjustments, totalPremium, enrollmentStatus, otherPaymentAmount, otherPaymentAmount2) {
		var urlToLoad =  "/"+appName+"/memberMaintenance/defaultRenderInvoiceAsPDF?invoiceId=" + invoiceId + "&subscriberId="+subscriberId + "&issuerSubscriberId="+issuerSubscriberId +"&fedAPTCAmt="+fedAPTCAmt +"&arAccountId="+arAccountId+"&firstName="+firstName+"&lastName="+lastName+"&planCode="+planCode+"&transfers="+transfers+"&manualAdjustments="+manualAdjustments+"&retroAdjustments="+retroAdjustments+"&totalPremium="+totalPremium+"&enrollmentStatus="+enrollmentStatus+"&otherPaymentAmount="+otherPaymentAmount+"&otherPaymentAmount2="+otherPaymentAmount2;
		openModalWindow (urlToLoad, null,false);
	}
	
	//Multiplan - Load Invoice Details Screen
	function loadInvoiceDetails(invoiceId, subscriberId, issuerSubscriberId, arAccountId) {
		var urlToLoad =  "/"+appName+"/memberMaintenance/getInvoiceDetails?invoiceId=" + invoiceId + "&subscriberId="+subscriberId + "&issuerSubscriberId="+issuerSubscriberId + "&arAccountId="+arAccountId
		openModalWindow (urlToLoad, null,false);
	}
	
	//Multiplan - Load Quote Details Screen
	function loadQuoteDetails(subscriberId) {
		var urlToLoad =  "/"+appName+"/memberMaintenance/getQuoteDetails?subscriberId="+subscriberId;
		openModalWindow (urlToLoad, null,false);
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
	function payByPhone(subscriberId, currentAccountBalance, arAccountId) {
		var urlToLoad =  "/"+appName+"/memberMaintenance/payByPhone?subscriberId=" + subscriberId + "&currentAccountBalance="+currentAccountBalance+ "&arAccountId="+arAccountId;
		openModalWindow (urlToLoad);
	}
	</script>
	<script type="text/javascript">
		function confirmDialog(subscriberId, seqSubsEftInfoId) {
		    // Define the Dialog and its properties.
			$(document).ready(function() {
				
				$('.BtnDeleteRow').click(function(e){
			             $('#DeleteAlertModal').modal('show');
			         });
			      $('#DeleteAlertModal').modal( {
				      backdrop: 'static',
				       show: false 
				  });
			      $("#BtnDeleteRowYes").click(function(e){	  		         
			    	  confirmCallback(true, subscriberId, seqSubsEftInfoId);
			      });
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

<div id="fms_content">
      <div id="fms_content_header">
        <div class="fms_content_header_note">
          <a href="member-maintenance.html">Member Maintenance</a> / Dashboard for Subscriber ID ${params.subscriberId}
        </div>
        <div class="fms_content_title">
          <h1>Dashboard</h1>
        </div>
      </div> 


      <%-- START - Tabs --%>
        <div id="fms_content_tabs">
          <ul>
            <li><g:link class="active" action="memberDashboard1" title="Click to view Dashboard." id="${memberMasterList[0]?.subscriberID}" params="${[subscriberId: memberMasterList[0]?.subscriberID, personNumber: memberMasterList[0]?.personNumber, issuerSubscriberId:memberMasterList[0]?.currentEligibilityPeriod?.issuerSubscriberId]}">Dashboard</g:link></li>
            <li><g:link class="list" action="show" id="${memberMasterList[0]?.subscriberID}" params="${[editType :'MASTER']}">Master Record</g:link></li>
            <li><g:link class="list" action="show" id="${memberMasterList[0]?.subscriberID}" params="${[editType :'DETAIL']}">Eligibility Details</g:link></li>
            <li><g:link class="list" action="show" id="${memberMasterList[0]?.subscriberID}" params="${[editType :'ADDRESS']}">Addresses</g:link></li>
            <li><g:link class="list" action="show" id="${memberMasterList[0]?.subscriberID}" params="${[editType :'BILLING']}">Billing</g:link></li>
            <li><g:link class="list" action="show" id="${memberMasterList[0]?.subscriberID}" params="${[editType :'BENEFICIARY']}">Manage Beneficiaries</g:link></li>
            <li><g:link class="list" action="show" id="${memberMasterList[0]?.subscriberID}" params="${[editType :'BENEFICIARY_ALLOCATION']}">Beneficiary Allocation</g:link></li>
            <li><g:link class="list" action="show" id="${memberMasterList[0]?.subscriberID}" params="${[editType :'MEDICARE_ENROLLMENT_INFO']}">Medicare Enrollment Information</g:link></li>
			<li><g:link class="list" action="show" id="${memberMasterList[0]?.subscriberID}" params="${[editType :'MEMMC_LIS_INFO']}">Medicare Low Income Subsidy Info</g:link></li>
			<li><g:link class="list" action="show" id="${memberMasterList[0]?.subscriberID}" params="${[editType :'MMR_PMT_DTL']}">CMS MMR Payment Detail</g:link></li>         
	      </ul>
          <div id="mobile_tabs_select"><label class="control-label sr-only" id="mobile_tabs_label" for="mobile_tabs">This select displays instead of tabs list at smaller viewport sizes.</label><select class="form-control" id="mobile_tabs" name="mobile_tabs" aria-labelledby="mobile_tabs_label" aria-required="false"><option selected="selected" value="member-dashboard.html">Dashboard</option><option value="member-masterrecord.html">Master Record</option><option value="member-detailrecord.html">Detail Records</option><option value="member-addresses.html">Addresses</option><option value="member-billing.html">Billing</option><option value="member-beneficiaries.html">Beneficiary Management</option><option value="member-allocation.html">Beneficiary Allocation</option><option value="member-memmc.html">MEMMC LIC Info</option></select></div>
        </div>
      <%-- END - Tabs --%>

      <%-- START - Jump To: --%>
        <div id="jumpto">
          <div class="jumpto_inner">
            <ul>
             <g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshMemberNotes"><li><a href="#WidgetNotes">Notes</a></li></g:checkURIAuthorization>
             <g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshMemberEnrollment"><li><a href="#WidgetInfo">Member Information</a></li></g:checkURIAuthorization>
             <g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshMemberEligibility"><li><a href="#WidgetEligibility">Eligibility History</a></li></g:checkURIAuthorization>
             <g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshMemberDemographics"><li><a href="#WidgetDemographics">Member Address Information</a></li></g:checkURIAuthorization>
             <g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshMemberBillInfo"><li><a href="#WidgetQuote">Account Information</a></li></g:checkURIAuthorization>
             <g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshMemberBillHist"><li><a href="#WidgetBilling">Billing History</a></li></g:checkURIAuthorization>
             <g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshEftSubscription"><li><a href="#WidgetSubscription">EFT Subscription Information</a></li></g:checkURIAuthorization>
             <%--<g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshMemberPayHist"><li><a href="#WidgetPayment">Payment Information</a></li></g:checkURIAuthorization> --%>
             <g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshMemberNotice">	<li><a href="#WidgetNotices">Notices</a></li></g:checkURIAuthorization>           
             <g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshEftPaymentDetails"><li><a href="#WidgetEFTPayment">EFT Payment Details</a></li></g:checkURIAuthorization>         
            </ul>
          </div> 
        </div>      
      <%-- END - Jump To: --%>


      <div id="fms_content_body" onLoad="showEFTConfiguration();">
      		<g:if test="${flash.message}">
				<div id="SearchNoResults" class="fms_widget fms_widget_border fms_widget_bgnd-color">
					<p><div class="message" role="status">${flash.message}</div></p>
				</div>
				<BR>
			</g:if>
        <%--<div class="fms_required_legend fms_required">= required</div>--%>
                  
			<g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshMemberNotes">
			 <div class="fms_table_wrapper">
		        <div id="WidgetNotes" class="fms_widget">
		          <h3>Notes <g:checkURIAuthorization uri="/memberMaintenance/ajaxCreateNote">	
								<g:hiddenField id="ajaxSubscriberId" name="ajaxSubscriberId" value="${params.subscriberId}" />						
								<g:remoteLink action="ajaxCreateNote" class="btn btn-primary btn-sm"
										params="${[subscriberId :params.subscriberId]}" oncomplete="" before="checkLoggedIn('/memberMaintenance/ajaxCreateNote')" 
										onloading="" update="memberNotesTable"><i class="fa fa-plus"></i> New Note</g:remoteLink></g:checkURIAuthorization></h3>
		          <g:render template="dashboard/memberNotes" model="[memberMasterList: memberMasterList]" />
		        </div>
		      </div>
	        </g:checkURIAuthorization>

			<g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshMemberEnrollment">
			<div class="fms_table_wrapper">
		        <div id="WidgetInfo" class="fms_widget">
		          <h3>Member Information</h3>
		          	<g:render template="dashboard/memberEnrollment" model="[memberMasterList: memberMasterList]" />
		        </div>
		     </div>
		     </g:checkURIAuthorization>

			<g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshMemberEligibility">
			<div class="fms_table_wrapper">
        		<div id="WidgetEligibility" class="fms_widget">
          			<h3>Current Eligibility History</h3>
                  	<g:render template="dashboard/memberEligibility" model="[memberMasterList: memberMasterList, billingInformation: billingInformation]" />
        		</div>
        	</div>
        	</g:checkURIAuthorization>

			<g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshMemberDemographics">
			<div class="fms_table_wrapper">
		        <div id="WidgetDemographics" class="fms_widget">
		          <h3>Member Address Information</h3>
		          <g:render template="dashboard/memberDemographics" model="[memberMasterList: memberMasterList]" />
		        </div>
		      </div>
		    </g:checkURIAuthorization>

 			<g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshMemberBillInfo">
 				<div class="fms_table_wrapper">
			        <div id="WidgetQuote" class="fms_widget">		        	
						<h3>Account Information</h3>
						<g:render template="dashboard/billingInformation" model="[memberMasterList: memberMasterList]" />
			        </div>
		      	</div>
			</g:checkURIAuthorization>
			
			<g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshMemberBillHist">
				
				<div class="fms_table_wrapper">
			        <div id="WidgetBilling" class="fms_widget">			
			        	<h3>Billing History</h3>
			        	<div id="memberBillHistTable">
			        		<g:render template="dashboard/billingHistory" model="[memberMasterList: memberMasterList]" />
			        	</div>
			        	<br>
			        	<g:if test="${params.showAllInvoices == null}">
			        	<div class="btn btn-primary btn-sm" onclick="window.location.assign('/${appContext.metadata['app.name']}/memberMaintenance/memberDashboard1?subscriberId=${params.subscriberId}&showAllInvoices=true')"> 
							&nbsp;&nbsp;Show All Invoices&nbsp;&nbsp;</div>
						</g:if>
			        </div>			       
			    </div>
			</g:checkURIAuthorization>
			
			<g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshEftSubscription">
				<div class="fms_table_wrapper">
			        <div id="WidgetSubscription" class="fms_widget">
			        	<h3>EFT Subscription Information</h3>
			        	<g:render template="dashboard/eftSubscription" model="[eftSubscriptionCommand: eftSubscriptionCommand]" />
			        </div>
		    	</div>
		    </g:checkURIAuthorization>
		<%--
		    <g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshMemberPayHist">  
		    	<div class="fms_table_wrapper">      
		        <div id="WidgetPayment" class="fms_widget">
		          <h3>Payment Information <button class="btn btn-primary btn-sm" onclick="updateEFT( 'Add one time Electronic Funds Transfer Information','1', '','',''  )"> &nbsp;&nbsp;Add a New One Time EFT &nbsp;&nbsp;</button>
										<button class="btn btn-primary btn-sm" onclick="updateEFT( 'Set up Recurring Electronic Funds Transfer Information','2','','',''  )"> &nbsp;&nbsp;Setup a new Recurring EFT &nbsp;&nbsp;</button></h3>
		         <g:render template="dashboard/paymentInformation" model="[memberMasterList: memberMasterList]" />
		         <div id="eftConfigurationPeriod" style="display:none">
								<h4>Bank Account Information</h4>
								<form name="eftForm">
									<table class="tablesorter tablesorter-fms tablesorter26ba9e6columnselector" role="grid" aria-describedby="DataTable_pager_info" >
										<div id="premimValue" style="display: none">
											<tr>			
																<td>Pay Current Amount :</td>
																<td><g:formatNumber number="${billingInformation?.currentAccountBalance }" format="\$###,##0.00" />
																	<div style="display:${billingInformation?.currentAccountBalance > 0?'none':'inline' }">  (No Payment required)</div>
																</td>
											</tr>
											<tr>
																<td>Payment Amount :</td>
																<td><input type="text" id="paymentAmount" value="" /></td>												
											</tr>
										</div>

										<div id="dates" style="display: none">
											<tr>
												<td>Start Date :</td>
												<td><g:datePicker name="startDate" 
										                       id="startDate"
										                       precision="day" 
										                       value="${params.startDate}" 
									                       	   noSelection="['':'']" 
										                       relativeYears="[-100..5]" 
										                       default="none"/>		
												</td>
											</tr>
											<tr>
												<td>End Date :</td>
												<td style="border-bottom: 0px; vertical-align: middle;">
													<g:datePicker name="endDate" 
									                       id="endDate"
									                       precision="day" 
									                       value="${params.endDate}" 
								                       	   noSelection="['':'']" 
									                       relativeYears="[-100..5]" 
									                       default="none"/>
										         </td>
											</tr>
										</div>

										<tr>
											<td>Account Type :</td>
											<td><select id="accountType">
														<option value="">--Select Account Type --</option>
														<option value="checking">Checking</option>
														<option value="saving">Saving</option>
												</select>
											</td>
										</tr>
										<tr>
											<td>Routing Number :</td>
											<td><input type="text" id="accoutNumber" value="" /></td>
										</tr>
										<tr>
											<td>Account Number :</td>
											<td><input type="text" id="accoutNumber" value="" /></td>
										</tr>
										<tr>
											<td>Confirm Account Number :</td>
											<td><input type="text" id="confAccoutNumber" value="" /></td>
										</tr>
										<div id="accountStatusDiv" style="display: none">										
											<tr>
												<td>Account Status :</td>
												<td><input type="text" id="accountStatus" value="" disabled="disabled" /></td>
											</tr>													
										</div>
										<tr>
											<td><span><input class="btn btn-primary btn-sm" id="saveButton" type="button" name="saveEFTConfigPeriod" value="Add/Update Payment" /></span></td>
											<td></td>
										</tr>
									</table>
                                    
								</form>
							</div>
		        </div>
		        </div>
		    </g:checkURIAuthorization>
		 --%>
			<g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshMemberNotice">
			<div class="fms_table_wrapper">
		        <div id="WidgetNotices" class="fms_widget">
		          <h3>Notices</h3>
		          	<g:render template="dashboard/memberNotices" model="[notices: notices]" />
		          	<br>
		        	<g:if test="${notices && notices.size() > 10}">
		        		<div class="btn btn-primary btn-sm" onclick="window.location.assign('/${appContext.metadata['app.name']}/memberMaintenance/memberDashboard1?subscriberId=${params.subscriberId}&showAllNotices=true')"> 
							&nbsp;&nbsp;Show All Notices&nbsp;&nbsp;</div>
					</g:if>	
		    		</div>
		    	</div>
			</g:checkURIAuthorization>
			
			<g:checkURIAuthorization uri="/memberMaintenance/ajaxRefreshEftPaymentDetails">
			<div class="fms_table_wrapper">
		        <div id="WidgetEFTPayment" class="fms_widget">
		          <h3>EFT Payment Details</h3>
		         <g:render template="dashboard/eftSubscriberPayment" model="[eftPaymentDetails: eftPaymentDetails]" />
		    	</div>
		    </div>
		    </g:checkURIAuthorization>
    </div>
</div>
 
<div class="modal fade" id="DeleteAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
	<div class="modal-dialog">
		<div class="modal-content fms_modal_error">
			<div class="modal-body">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4>Are you sure you want to void the payment?</h4>            
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">No</button>
				<button id="BtnDeleteRowYes" type="button" class="btn btn-primary" data-dismiss="modal">Yes</button>	</div>
		</div>
	</div>
</div>
