<%@ page import="com.perotsystems.diamond.bom.Group"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<!-- Main menu select -->
<meta name="navSelector" content="maint"/>
<!-- Child menu select -->
<meta name="navChildSelector" content="searchJobs"/>

<g:set var="entityName"
	value="${message(code: 'memberChangeEvent.label', default: 'Group')}" />
	
<g:set var="appContext" bean="grailsApplication"/>
	
<title>Search Member Groups</title>
<!-- JavaScript Includes -->
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>

<script language="javascript">

	// Below line is added as on click of clear button we have to clear records as well.				
				$('#SearchResults').hide();  
				$('.message').hide();
				$('.errors').hide();
				$('#SearchNoResults').hide();
				
				
	function clearSearchCriteria() {
		var elements = document.getElementsByTagName("input");
		var firstText = true;
		for ( var ii = 0; ii < elements.length; ii++) {
			if (elements[ii].type == "text") {
				elements[ii].value = "";
				if (firstText) {
				    firstText = false;
			    	elements[ii].focus();
			    	var clear_btn = document.getElementById('Create_id') 		    	
                    if(clear_btn!= null)
			    	{                    	
			    	clear_btn.style.visibility="hidden"
			    	var membr_maintaince_meaage_div = document.getElementById("grp_maintance_message_id")
		        	var membr_maintaince_meaage_div_value = document.getElementById("grp_maintance_message_id").innerHTML
		  	        if(membr_maintaince_meaage_div_value!=null)
		  	        {		  	        	
		  	         membr_maintaince_meaage_div.style.visibility="hidden"
		  	        }
			    	}  
 

			    	
				 }
			}
			/*if (elements[ii].type == "radio") {
				elements[ii].checked = false;
			}*/
		}
		var elements = document.getElementsByTagName("select");
		for ( var ii = 0; ii < elements.length; ii++) {
			elements[ii].selectedIndex = 0;
		}
	}

	function createGroup() {
		var createGroupID = "${params.groupId}"
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/groupMaintenance/create?groupId="
				+ createGroupID + "&groupEditType=MASTER")
	}
	function setFirstElementFocus() {		
		var firstText = true;
		var elements = document.getElementsByTagName("input");
		for (var ii=0; ii < elements.length; ii++) {
			  if (elements[ii].type == "text") {
			    if (firstText) {
				    firstText = false;
			    	elements[ii].focus();
			    	//break;
				 }
			  }
		}
	}
	
	function checkForSearchCritera(){
	
		var elements = document.getElementsByTagName("input");
		var searchCriteria = false;
		
		for (var ii=0; ii < elements.length; ii++) {
		  if (elements[ii].type == "text") {
		    if(elements[ii].value){
			    searchCriteria = true;
			    }
		  }
		}

		var selects = document.getElementsByTagName("select");
		for (var ii=0; ii < selects.length; ii++) {
		  if (elements[ii].type == "text" && selects[ii]) {
		    if(selects[ii].value != ""){
			    searchCriteria = true;
			}
		  }
		}
			
		 
		    if(searchCriteria == false){
			//alert ("Please enter search criteria to find results.");
			  document.getElementById('BtnInfoAlertId').click();
		  }
		  
		  return searchCriteria;
		
	}

	$(function($){
		   $("#IdGroupId").alphanum({
			    allow 		: '-_',
			    allowSpace  : false
			});

	})
</script>
<script type="text/javascript">
$(document).ready(function() { 

	      $('#BtnClear').click(function(e){
	        $('#SearchNoResults, #SearchResults').addClass('hidden');
	      });
	});
	
	$(document).ready(function() {

$(".tablesorter").tablesorter({
    theme: 'blue',
    initialized: function (table) {
        $(".tablesorter").find(".show-disable-icon").removeClass("sorter-false");
        
        var sortvar = getQueryVariable('sort');
        var order = getQueryVariable('order');
        var expr = 'tr[class="tablesorter-headerRow"] th[id^="' + sortvar + '"]'
        var sortID = $(expr).attr('id');
        
        if(sortvar!== -1) {
            $("#" + sortID).removeClass("tablesorter-headerDesc");
            $("#" + sortID).removeClass("tablesorter-headerAsc");
            if (order === 'desc') {
                $("#" + sortID).addClass("tablesorter-headerDesc");
            } else {
                $("#" + sortID).addClass("tablesorter-headerAsc");
            }
        }            
    },

    widgets: ['zebra', 'columnSelector'],
    widgetOptions : {
      columnSelector_container : $('#columnSelector'),
      columnSelector_saveColumns: true,
      columnSelector_mediaquery: false,      
      columnSelector_layout : '<label><input type="checkbox">{name}</label>',
      columnSelector_cssChecked : 'checked',


      // Hide/Show columns based on viewport width 
      columnSelector_mediaquery: true,
      columnSelector_mediaqueryState: false,
      columnSelector_mediaqueryName: 'Auto display columns: ',
      columnSelector_priority : 'data-priority'
    }
});

$(".show-disable-icon").click(function (evt) {
    var columnRef = evt.currentTarget.id;
    var url = $("#" + columnRef).attr("data-sorturl");
   
    
    var newURL = url;// + "&sort=" + columnRef+"&order="+ad;
    window.location = newURL;
    
});

function getQueryVariable(variable) {
    var query = window.location.search.substring(1);
    var vars = query.split("&");
    for (var i = 0; i < vars.length; i++) {
        var pair = vars[i].split("=");
        if (pair[0] == variable) {
            return pair[1];
        }
    }
    return -1;
}

});
	
</script>
<script type="text/javascript">
		$(document).ready(function() { 
		
			$('.btnInfoAlert').hide();  
			$('.btnInfoAlert').click(function(e){ 
		    	$('#BlankAlertModal').modal('show');
		    });
		 	$('#BlankAlertModal').modal({
		    	backdrop: 'static',
		       show: false
		   	});
		});
		
		</script>

</head>
<div id="fms_content">

		<!-- START - FMS Content Header -->
			<div id="fms_content_header">
				<div class="fms_content_header_note">
		      		<a href="/FMSAdminConsole/commissions/searchJobs">Commissions Maintenance</a>
		      			/Add Group(s) 
	  			</div>
			<div class="fms_content_title">
          		<h1>Add Group(s)</h1>
          		
        	</div> 
      	</div>
      	<div id="fms_content_body">
			
           	<p>           		
           	<%-- Error messages start--%>
	<div id="list-memberChangeEvent" class="content scaffold-list" role="main">
		<g:if test="${flash.message}">
			<div class="message" role="status" id="grp_maintance_message_id">
				${flash.message}
			</div>
		</g:if>
		
				<g:if test="${fieldErrors}">
			<ul class="errors" role="alert">
				<g:each in="${fieldErrors}" var="error">
					<li>
						${error}
					</li>
				</g:each>
			</ul>
		</g:if>
		<ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>
			<%-- Error messages end--%>
			</p>
		</div>
		<form name="searchForm" action="/${appContext.metadata['app.name']}/commissions/addGroups">
			<input type="hidden" name="seqBatchId" value="${seqBatchId}">
			<input type="hidden" name="searchRef" value="searchForm">
			<input type="hidden" name="editType" value="${editType}">
			<input type="hidden" name="sort" value="${request.getParameter('sort') != null ?request.getParameter('sort'):'groupId'}" />
      		<input type="hidden" name="order" value="${request.getParameter('order') != null ?request.getParameter('order'):'asc'}" />
		
			<div id="DataTableSection">
					 <div class="fms_widget fms_form_container">
		            <div class="fms_form_header">            
		              <h2>Find and Add Groups to Batch</h2>
		              <a href="#" class="fms_form_header_close" title="Hide Form"><i class="fa fa-minus-square"></i></a>
		            </div>
		
		          <div class="fms_form">
		          	<div class="fms_form_body">
		
		               <div class="fms_form_layout_2column">                  
		                  <div class="fms_form_column fms_long_labels">

		                  	<label class="control-label" for="IdGroupId" id="IdGroupId_label">
		                  		Group Id :
		                  	</label>
                  			<div class="fms_form_input">
		                        <input 
		                        class="form-control enterField" 
		                        type="text" 
		                        name="groupId"
								id="IdGroupId" value="${params.groupId}"
								maxlength="50" onclick='javascript: IdGroupId.value = ""' autofocus="autofocus"
								aria-labelledby="IdGroupId_label" 
								aria-describedby="IdGroupId_error" 
								aria-required="false"> 
		                        <div class="fms_form_error" id="IdGroupId_error"></div>
                  			</div>
                  			
                  			<label class="control-label" for="IdGroupShortName" id="IdGroupShortName_label">
							Short Name :
							 </label>
                  			<div class="fms_form_input">
		                       <input 
		                       	class="form-control enterField" 
		                       	type="text"
								name="groupShortName"
								id="IdGroupShortName"
								value="${params.groupShortName}"
								maxlength="15"
								aria-labelledby="IdGroupShortName_label" 
								aria-describedby="IdGroupShortName_error" 
								aria-required="false">
		                        <div class="fms_form_error" id="IdGroupShortName_error"></div>
                  			</div>
	                     </div>
	                     
	                      <div class="fms_form_column fms_long_labels">	
	                     
							<label class="control-label" for="IdGroupName1" id="IdGroupName1_label">
							Name 1:	 
							</label>
                   				<div class="fms_form_input">
		                      <input 
		                     	class="form-control enterField" 
		                      	type="text"
								name="groupName1" 
								id="IdGroupName1"
								value="${params.groupName1}"
								maxlength="40"
								aria-labelledby="IdGroupName1_label" 
								aria-describedby="IdGroupName1_error" 
								aria-required="false">
		                        <div class="fms_form_error" id="IdGroupName1_error"></div>
                   			</div>	
                   			
                   			<label class="control-label" for="IdGroupName2" id="IdGroupName2_label">
								Name 2:
								</label>
                    				<div class="fms_form_input">
				                     <input 
				                     	class="form-control enterField" 
				                     	type="text"
										name="groupName2" 
										id="IdGroupName2"
										value="${params.groupName2}" 
										maxlength="40"
										aria-labelledby="IdGroupName2_label" 
										aria-describedby="IdGroupName2_error" 
										aria-required="false">
			                        <div class="fms_form_error" id="IdGroupName2_error"></div>
         						</div>
					          </div>
					       </div>	
					       </div>
					       <% def style_plan = plan_lob.equals('checked') ?'style="display:block"':'style="display:none"'%>
					      <div class="fms_form_button">
					       <input class="btn btn-primary" type="submit" value="Search" onClick="return checkForSearchCritera()">
											<g:if test="${params.groupId && create}">											
												<input class="btn btn-primary" type="button" id="Create_id" 
												value="Create group - ${params.groupId }" onClick="createGroup()">
											</g:if>
							<input type="button" class="btn btn-default" value="Reset"
											onClick="document.forms['searchForm'].reset();setFirstElementFocus()"> 
							<input id="BtnClear" type="button" class="btn btn-default" value="Clear"
											onClick="clearSearchCriteria()">
							<button id="BtnInfoAlertId" type="button" class="btn fms_btn_icon btn-sm btnInfoAlert" title="Click to reset language form." data-target="#BlankAlertModal"></button>  
							 </div>
					           </div>
					      </form>
					      		<br></br>
			<!-- If records found --> 
							<g:if test="${groupMasterTotal>0}">
							<% Group event = groupMasterList.get(0)
				session.setAttribute('groupDBID', event.groupDBId)
				session.setAttribute('groupId', event.groupId)%>

				<div id="SearchResults" class="fms_widget">
          			
            		<div class="fms_widget">
	              		<h2>Group Search Results</h2>
						<!-- Column Selector starts here -->
						<div class="row fms-col_selector_row">
							<div id="SearchResultsFound" class="col-xs-6 fms-results-found">${groupMasterTotal} Results Found</div>
							<div class="col-xs-6 fms-column-selector">
								<div class="columnSelectorWrapper">
									<input id="colSelect1" type="checkbox" class="hidden columnSelectorcolSelect1" />
									<label class="columnSelectorButton" for="colSelect1" title="Hide and Show Columns"><i class="fa fa-columns"></i>&nbsp;&nbsp;<i class="fa fa-caret-down"></i></label>
									<div id="columnSelector" class="columnSelector">                	
									<!-- this div is where the column selector is added -->
				    
									</div> 
								</div>
							</div>
						</div>
					<!-- Column Selector ends here -->
					<div class="fms_table_wrapper">
                		<table id="DataTable" class="tablesorter tablesorter-fms tablesorter26ba9e6columnselector" role="grid" aria-describedby="DataTable_pager_info">
                  			<thead>
                    			<tr role="row" class="tablesorter-headerRow">
                    				<fmsui:sortableColumn property="groupId" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="1" data-column="0" aria-disabled="false"
										title="${message(code: 'Group.memberChangeEventId.label', default: 'Group Id')}"
										params="${[groupId:params.groupId]}" />
									<fmsui:sortableColumn property="shortName" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="2" data-column="1" aria-disabled="false"
										title="${message(code: 'Group.groupId.label', default: 'Short Name')}"
										params="${[groupId:params.groupId]}" />
									<fmsui:sortableColumn property="name1" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="3" data-column="2" aria-disabled="false"
										title="${message(code: 'Group.changeEventType.label', default: 'Name 1')}"
										params="${[groupId:params.groupId]}" />
									<fmsui:sortableColumn property="name2" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="4" data-column="3" aria-disabled="false"
										title="${message(code: 'Group.retroEnabled.label', default: 'Name 2')}"
										params="${[groupId:params.groupId]}" />
									<fmsui:sortableColumn property="levelCode" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="5" data-column="4" aria-disabled="false"
										title="${message(code: 'Group.oldPeriodStartDate.label', default: 'Group Level')}"
										params="${[groupId:params.groupId]}" />
									<fmsui:sortableColumn property="holdDate" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="6" data-column="5" aria-disabled="false"
										title="${message(code: 'Group.oldPeriodEndDate.label', default: 'Hold Date')}"
										params="${[groupId:params.groupId]}" />
									<fmsui:sortableColumn property="holdReason" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="7" data-column="6" aria-disabled="false"
										title="${message(code: 'Group.newPeriodStartDate.label', default: 'Hold Reason')}"
										params="${[groupId:params.groupId]}" />
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="7" data-columnselector="disable" aria-disabled="true">Actions</th>
					            </tr>
						</thead>
						<tfoot>
							<g:if test="${groupMasterTotal > Integer.parseInt(grailsApplication.config.fms.admin.pageSize)}">
							<th colspan="8" data-column="0" class="tablesorter-headerAsc">
								<div id="DataTablePager" class="pager tablesorter-pager">
									<span class="right">
										<div class="pagination">
											<g:paginate total="${groupMasterTotal}"
												params="${[groupId:params.groupId, groupShortName:params.groupShortName, groupName1:params.groupName1, groupName2:params.groupName2]}" />
										</div>               
									</th>  
							</g:if> 
	                  	</tfoot>	
              			<g:each in="${groupMasterList}" status="i" var="groupMaster">
              			<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
              				<td> ${fieldValue(bean: groupMaster, field: "groupId")}</td>
              				<td> ${fieldValue(bean: groupMaster, field: "shortName")}</td>
              				<td> ${fieldValue(bean: groupMaster, field: "name1")}</td>
              				<td> ${fieldValue(bean: groupMaster, field: "name2")}</td>
              				<td><g:if test="${groupMaster?.levelCode?.toString().equals('1')}">
								Group
								</g:if>
								<g:elseif test="${groupMaster?.levelCode?.toString().equals('2')}">
								Super Group
								</g:elseif>
								<g:elseif test="${groupMaster?.levelCode?.toString().equals('3')}">
								Administrator Group
								</g:elseif>
							</td>
              				<td><g:formatDate format="yyyy-MM-dd" date="${groupMaster.holdDate}" /></td>
              				<td>${fieldValue(bean: groupMaster, field: "holdReason")}</td>
              				<td>	<g:link class="btn btn-primary" action="addGroupToBatch" id="${groupMaster.groupDBId}"
										params="${[seqBatchId:seqBatchId, groupDBId: groupMaster.groupDBId, editType:editType]}">
										Add To Batch
									</g:link>
							</td>
						</tr>
					</g:each>
				</table>
			</div>
		</div>
	</div>
</g:if>
</div>
</div>
<!-- START - BlankAlertModal  -->
<div class="modal fade" id="BlankAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog">
			<div class="modal-content fms_modal_error-sm">
			<div class="modal-body">
			  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			  <h5>Please enter search criteria to find results</h5>            
			</div>

				<div class="modal-footer text-center">
					<button type="button" class="btn btn-default" data-dismiss="modal">OK</button>     
				</div>
			</div>
		</div>
</div>
		<!-- END - DBlankAlertModal -->

</html>
	