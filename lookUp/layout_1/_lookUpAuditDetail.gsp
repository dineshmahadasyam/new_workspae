<!DOCTYPE html>
<html lang="en">
	<head>
	    <meta charset="utf-8" />
	    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
	    <meta name="viewport" content="width=device-width, initial-scale=1" />
			<g:set var="appContext" bean="grailsApplication"/>    
	    <title>FMS - Member Maintenance</title>
	    
	    <link href="${resource(dir: '/css/layout_1_css', file: 'font-awesome.min.css')}" rel="stylesheet" type="text/css"></link>
	    <link href="${resource(dir: '/css/layout_1_css', file: 'bootstrap.min.css')}" rel="stylesheet" type="text/css"></link> 
	    <link href="${resource(dir: '/js/layout_1_scripts/tablesorter', file: 'jquery.tablesorter.pager.css')}" rel="stylesheet" type="text/css"></link> 
	    <link href="${resource(dir: '/js/layout_1_scripts/jquery-ui', file: 'jquery-ui.min.css')}" rel="stylesheet" type="text/css"></link>
	    <link href="${resource(dir: '/css/layout_1_css', file: 'fms-main.css')}" rel="stylesheet" type="text/css"></link>   
	
	    <!-- jQuery -->
	    <script src="${resource(dir: '/js/layout_1_scripts', file: 'jquery-1.11.3.min.js')}"></script>
	    
	   <!-- Tablesorter: required -->  
	    <script src="${resource(dir: '/js/layout_1_scripts/tablesorter', file: 'jquery.metadata.js')}" ></script>
	    <script src="${resource(dir: '/js/layout_1_scripts/tablesorter', file: 'jquery.tablesorter.js')}" ></script>
	    <script src="${resource(dir: '/js/layout_1_scripts/tablesorter', file: 'jquery.tablesorter.pager.js')}" ></script>
	    <script src="${resource(dir: '/js/layout_1_scripts/tablesorter', file: 'widget-columnSelector.js')}" ></script>
	    <script src="${resource(dir: '/js/layout_1_scripts/tablesorter', file: 'jquery.tablesorter.widgets.js')}" ></script>
    	<script>
			var total = ${cdoCollectionSize};
			var htmlElementName= "${htmlElementIdName}";
			var cdoClassName = "${cdoClassName}";
			var cdoClassAttributeName = "${cdoClassAttributeName}";
	
			parent.lookupElementtoFocusOnCloseId = "${htmlElementIdName}";
						
			function fnClose(lookUpId, selectedIndex) {
				top.document.getElementById(htmlElementName).value= lookUpId;
				return parent.closeModal(htmlElementName);			
			}
			function fnReloadLookup() {
				var srchBatchId1 = document.forms["searchLookUpForm"].srchBatchId.value
				if (srchBatchId1) {
					top.document.getElementById(htmlElementName).value= srchBatchId1;				
					//top.document.getElementById("genericLookUpButton").click();
					parent.lookup(htmlElementName,cdoClassName,cdoClassAttributeName,srchBatchId1)
				}
			}
			/*****************************************************/ 
			/* Script: Close the tablesorter ColumnSelector menu
			           when the window is resize or anything other 
			           then the ColumnSelectorButton is clicked
			*/ 
			/*****************************************************/ 
	
			  $( window ).resize(function() {
			      CloseColumnSelector();
			  });
	
			  // On any click on the page
			  $('*').click(function(e) {        
			      // If element is not the Column Selector
			      if(! $(e.target).closest(".columnSelectorWrapper").length ) {
			          CloseColumnSelector(); 
			      }
			  });
	
			  function CloseColumnSelector() {
			      // Uncheck menu checkbox which hides menu
			      $( "input[class*='columnSelectorcolSelect']" ).attr('checked', false);
			  }
			  
			  var parentBody = window.parent.document.body
			  $(parentBody).click(function(e){
			    CloseColumnSelector();
			  });
		</script>
	</head>
	<body style="background-image: none;">
		<div>
      		<div>
				<g:if test="${flash.message}">
					<div class="message" role="status">
						${flash.message}
					</div>
				</g:if>
				<g:if test="${flash.message1}">
					<p class="error">${flash.message1}</p>
				</g:if>
				<g:else>
					<br>
				</g:else>
				<g:if test="${("MEMBER_ELIG_HISTORY".equals(request.getParameter("auditedTableName"))) && ("U".equals(request.getParameter("databaseAction")))}">
					<div class="fms_widget form-inline" style="padding-bottom:0;">
			 			<input type="hidden" name="sort" value="${request.getParameter('sort') != null ?request.getParameter('sort'):''}" />
		     			<input type="hidden" name="order" value="${request.getParameter('order') != null ?request.getParameter('order'):'asc'}" />
     			
		     			<input type="hidden" name="cdoCollection" value="${request.getParameter('cdoCollection') ? request.getParameter('cdoCollection') : 'cdoCollection' }">
						<input type="hidden" name="fields" value="${request.getParameter('fields') ? request.getParameter('fields') : 'fields' }">
						<input type="hidden" name="cdoClassName" value="${request.getParameter('cdoClassName') ? request.getParameter('cdoClassName') : 'cdoClassName' }">
						<input type="hidden" name="sort" value="${request.getParameter('sort') ? request.getParameter('sort') : 'windId' }">
						<input type="hidden" name="order" value="${request.getParameter('order') ? request.getParameter('order') : 'desc' }">
						<input type="hidden" name="offset" value="${request.getParameter('offset') ? request.getParameter('offset') : '0' }">
     			
						<div id="lookupSpinner" style="display:none">
							<img src="${resource(dir: '/images', file: 'spinner.gif')}" alt="Loading....." />
		   				</div>
      				</div>
      				<table>
						<tbody>
							<tr>
								<td>
									<span id="subscriberId-label" class="property-label">
									<g:message code="memberEligHistory.subscriberId.label" default="&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Subscriber Id: " />
									<g:fieldValue bean="${memberEligHistory}" field="subscriberId"/></span>
								</td>
								<td>
									<span id="personNumber-label" class="property-label">
									<g:message code="memberEligHistory.personNumber.label" default="&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Person Number: " />
									<g:fieldValue bean="${memberEligHistory}" field="personNumber" /></span>
								</td>
								<td>
									<span id="effectiveDate-label" class="property-label">
									<g:message code="memberEligHistory.effectiveDate.label" default="&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Effective Date: " />
									<g:formatDate format="dd-MMM-yy" date="${memberEligHistory.effectiveDate}"/></span>
								</td>
								<td>
									<span id="termDate-label" class="property-label">
									<g:message code="memberEligHistory.termDate.label" default="&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Term Date: " />
									<g:formatDate format="dd-MMM-yy" date="${memberEligHistory.termDate}"/></span>
								</td>				
							</tr>
						</tbody>
					</table>
				</g:if>		
				<form name="lookUpMainForm">
					<div class="fms-iframe-table">
						<div class="fms_widget">
							<div class="row fms-col_selector_row">
								<div id="BatchIDResultsFound" class="col-xs-6 fms-results-found">${cdoCollectionSize} Results Found</div>
							 	<div class="col-xs-6 fms-column-selector">
									<div class="columnSelectorWrapper">
										 <input id="colSelect1" type="checkbox" class="hidden columnSelectorcolSelect1">
										<label class="columnSelectorButton" for="colSelect1" title="Hide and Show Columns"><i class="fa fa-columns"></i>&nbsp;&nbsp;<i class="fa fa-caret-down"></i></label>
										<div id="columnSelector" class="columnSelector">
											<!-- this div is where the column selector is added -->
										</div> 
									</div>
								</div>
							</div>
						</div>	
						<div class="fms_table_wrapper0" >
							<table id="BatchIDResults1" class="tablesorter tablesorter-fms tablesorter26ba9e6columnselector" role="grid" aria-describedby="BatchIDResults_pager_info">
								<thead>
									<tr role="row" class="tablesorter-headerRow" >
										<g:each in="${fields}" status="i" var="field">
											<%
												String[] fieldLabelTokens = org.apache.commons.lang.StringUtils.splitByCharacterTypeCamelCase(org.apache.commons.lang.StringUtils.capitalize(field.name));
												String fieldLabel = "";
												fieldLabelTokens.each() { labelTok -> fieldLabel += labelTok + " " };
												fieldLabel = fieldLabel.trim();
											%>
											<fmsui:sortableColumn property="${field.name}" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="1" data-column="0" aria-disabled="false"
											titleKey="${field.name}.label" title="${fieldLabel}" 
											params="${[cdoClassName:request.getParameter('cdoClassName'), order:request.getParameter('order'), offset:request.getParameter('offset'), cdoClassAttributeName:request.getParameter('cdoClassAttributeName'), htmlElementValue:request.getParameter('htmlElementValue'), htmlElementIdName:request.getParameter('htmlElementIdName'), assocHTMLElementsValue:request.getParameter('assocHTMLElementsValue')]}" />
										</g:each>
									</tr>
								</thead>
								<tfoot>
								</tfoot>
								<tbody>
									<g:each in="${cdoCollection}" status="j" var="cdoObject">
										<tr class="${(j % 2) == 0 ? 'even' : 'odd'}">
											<%String searchKeyMethodName = cdoClassAttributeName							
												searchKeyMethodName = "get"+new String(searchKeyMethodName.charAt(0)).toUpperCase().concat(searchKeyMethodName.substring(1, searchKeyMethodName.length()))	
												java.lang.reflect.Method searchKeyGetMeth = cdoObject.getClass().getMethod(searchKeyMethodName)
											%>
											<g:each in="${fields}" status="q" var="cdoField">
												<%String getMethodName = cdoField.getName()							
													getMethodName = "get"+new String(getMethodName.charAt(0)).toUpperCase().concat(getMethodName.substring(1, getMethodName.length()))	
													java.lang.reflect.Method getMeth = cdoObject.getClass().getMethod(getMethodName)
											 %>
												<td>
												<g:if test="${java.util.GregorianCalendar.class.equals(cdoField.getType())}">								
													<g:formatDate  format="yyyy-MM-dd"  date="${getMeth.invoke(cdoObject) }" />
												</g:if>
												<g:else>
													${getMeth.invoke(cdoObject) }
												</g:else>
												</td>
											</g:each>
										</tr>
									</g:each>
								</tbody>
							</table>
						</div>
						<g:if test="${cdoCollectionSize > Integer.parseInt(grailsApplication.config.fms.admin.pageSize)}">
	                   		<div id="SearchResultsPager" class="pager tablesorter-pager" style="padding-bottom:0; padding-top:0;">      
								<div class="pagination">
									<span class="right">
										<g:paginate total="${cdoCollectionSize}" params="${[cdoCollection:request.getParameter('cdoCollection'), fields:request.getParameter('fields'), cdoClassName:request.getParameter('cdoClassName'), order:request.getParameter('order'), offset:request.getParameter('offset'), cdoClassAttributeName:request.getParameter('cdoClassAttributeName'), htmlElementValue:request.getParameter('htmlElementValue'), idName:request.getParameter('idName'), assocHTMLElementsValue:request.getParameter('assocHTMLElementsValue')]}"/>
									</span>
								</div>
							</div>
						</g:if>
					</div>
				</form>
			</div>
		</div>
	</body>
	<script type="text/javascript">
	 $(document).ready(function() {

		    $(".tablesorter").tablesorter({
		        theme: 'blue',
		        initialized: function (table) {
		            $(".tablesorter").find(".show-disable-icon").removeClass("sorter-false");

		            var sortvar = getQueryVariable('sort');
		            var order = getQueryVariable('order');
		            var expr = 'tr[class="tablesorter-headerRow"] th[id^="' + sortvar + '"]';
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
		        //var ad = Math.floor(Math.random() * 2);
		        
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
</html>	
	