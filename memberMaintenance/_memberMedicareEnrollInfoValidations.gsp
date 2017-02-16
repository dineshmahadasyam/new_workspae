<script type="text/javascript">
	//<![CDATA[ 
	$(window).load(function() {
		$('.hideme').find('div').hide();
		$('.clickme').click(function() {
			if($(this).parent().next('.hideme').find('div').is(":visible")){
				$(this).parent().children().children().get(0).checked = false;
			}else{
				$(this).parent().children().children().get(0).checked = true;
			}
			$(this).parent().next('.hideme').find('div').slideToggle(500);
			return false;
		});
		$(".alphaNumOnly").alphanum({
		});
		
		$(".selectradio").click(function(){
			if($(this).parent().parent().next('.hideme').find('div').is(":visible")){
				$(this).parent().children().get(0).checked = false;
			}else{
				$(this).parent().children().get(0).checked = true;
			}
			$(this).parent().parent().next('.hideme').find('div').slideToggle(500);
		});

	});//]]>
</script>
<script>
	var addRowClicked = false
	function cloneRow() {

		var divObjSrc = document.getElementById('newMemberEligibility')
		var divObjDest = document.getElementById('addGroupPlaceHolder')
		divObjDest.innerHTML = divObjSrc.innerHTML
		var divObj = document.getElementById('addAddressDiv')
		divObj.style.display = "none"
		var selectObj = document.getElementById("memberIdSelectList")
		selectObj.disabled = true;
		var divObjSrc = document.getElementById('releaseSelect')
		divObjSrc.style.display = "block"
		addRowClicked = true
	}
	
	var previousDivObj
	function releaseMemberSelection() {
		//alert("member selection relesed");
		var result = confirm(
				"Navigating to a new Member would result in the loss of data of the newly added member, Please confirm ",
				"Yes - Change Member ", "No - Stay on this page")
		if (result) {
			addRowClicked = false;
			var selectObj = document.getElementById("memberIdSelectList")
			//alert("member selection relesed");
			selectObj.disabled = false;
			var divObjSrc = document.getElementById('releaseSelect')
			divObjSrc.style.display = "none"
			var divObjDest = document.getElementById('addGroupPlaceHolder')
			divObjDest.innerHTML = "&nbsp;"
			var divObj = document.getElementById('addAddressDiv')
			divObj.style.display = "block"
			var resetButton = document.getElementById("resetButton")
			resetButton.click()
		}
	}
	function showAddress(selectedObj) {
		var hiddenObj = document.getElementById("editMemberDBID")
		if (!addRowClicked) {
			var selectedValue = selectedObj.options[selectedObj.selectedIndex].value
			var addressDivObj = document.getElementById(selectedValue)
			var addAddressDivObj = document.getElementById("addAddressDiv")
			hiddenObj.value = selectedValue
			if (addressDivObj != null) {
				if (previousDivObj != null) {
					previousDivObj.style.display = "none"
				}
				addressDivObj.style.display = "block"
				addAddressDivObj.style.display = "block"
				previousDivObj = addressDivObj
			} else {
				addAddressDivObj.style.display = "none"
			}
		} else {
			var result = confirm(
					"Navigating to a new Member would result in the loss of data of the newly added member, Please confirm ",
					"Yes - Change Member ", "No - Stay on this page")
			if (result) {
				addRowClicked = false;
				showAddress(selectedObj)
			} else {

			}
		}
	}
	function setDefault(rxpcn) {
		rxPcnValue =document.getElementById(rxpcn).value
		if(rxPcnValue == null || rxPcnValue.trim() == "")
			document.getElementById(rxpcn).value = "9999999999"
	}

	function gotoSearch() {
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/memberMaintenance/list");
	}
	
	function setDefaultDate(uiUserDate) {
		uiUserDateValue = document.getElementById(uiUserDate).value
		if(!uiUserDateValue){
			var today = new Date();
		    var dd = today.getDate();
		    var mm = today.getMonth()+1; //January is 0!

		    var yyyy = today.getFullYear();
		    if(dd<10){
		        dd='0'+dd
		    } 
		    if(mm<10){
		        mm='0'+mm
		    } 
		    var today = mm+'/'+dd+'/'+yyyy;
			document.getElementById(uiUserDate).value = today
		}
	}
	
	</script>
	
	<script type="text/javascript">
		
			$(document).ready(function() {

				$('.BtnCollapseRow').hide().removeClass('hidden');	

		      // Edit icon on table row
		         $('.tablesorter').delegate('.BtnEditRow, .BtnCollapseRow', 'click' ,function(e){
		          // e.preventDefault();  
		           var parentTR = $(this).closest('tr');
		           $(parentTR).find('.BtnEditRow, .BtnCollapseRow').toggle();
		           $(parentTR).nextUntil('tr:not(.tablesorter-childRow)').find('td').toggle();
		         });

		        // Save button 
		        $('.BtnSave').click(function(e){
		          //e.preventDefault();            
		          $('#SaveAlertModal').modal('show');
		        });
		        
		        // Save Modal
		        $('.BtnSaveModal').click(function(e){
		         // e.preventDefault();            
		          //this.form.submit(); // JQuery validations will not trigger
		          $('#editForm').submit();//resetForm();
		        });
		
		      // Undo button
		        $('.BtnUndo').click(function(e){
		          //e.preventDefault();            
		          $('#WarningAlertModal').modal('show');
		        });
		
		        $('.BtnUndoModal').click(function(e){
		          //e.preventDefault(); 
		          this.form.reset();
		          resetForm();           
		        });
		        		      
		        function resetForm(){
		            $('.BtnCollapseRow').hide();
		            $('.BtnEditRow').show();
		            $('.tablesorter-childRow td').hide();
		            //$('#BtnSave').attr('disabled','disabled');
		            //$('#BtnUndo').attr('disabled','disabled');
		            //$('.UnsavedChanges').hide();          
		          }
		        
		     // On form change enable the save and reset buttons
		       /* $('form :input').on('change input', function(e) {
		          $('#BtnSave').removeAttr('disabled');
		          $('#BtnUndo').removeAttr('disabled');
		        });	*/
		        
		      //$('#DataTable').removeClass( "hidden" );
		});
		</script>
	
	<script type="text/javascript">

	$(function(){
	    $(".numeric").numeric({});
	});
	$(function(){
		$(".alphanum").alphanum();
	});

	$(function(){
	    $(".amtNumeric").numeric({});
	    $(".qhpMask").mask("99999aa999999999");		
	});
	

$(document).ready(function(){
	
	$(function() {
		 var x = document.getElementsByClassName("amtNumeric");
		 var i;
		 for (i = 0; i < x.length; i++) {
			 if(x[i].value==''){
		     x[i].value="0.00";
			 }
		 }
	});	

jQuery.validator.setDefaults({
	ignore: [],
	  debug: true,
	 // success: "valid"
	});

$(function() {	
var selectObj = document.getElementById("memberIdSelectList");
$( "#editForm" ).validate({
	onfocusout: false,
	submitHandler: function (form) {
		  isInvalidForm = 'false';
		  if ($(form).valid()) 
              form.submit(); 
          return false; // prevent normal form posting
    },

  	
    	invalidHandler: function(form, validator) {
    	isInvalidForm = 'true';
        var errors = validator.numberOfInvalids();
        if (errors) {      
        	$(".message").hide();              
            validator.errorList[0].element.focus();
        }
    },
    
	errorLabelContainer: "#errorDisplay", 
	 wrapper: "li",	

	rules : {
		<g:if test="${memberEligHistoryMap}">
			<g:each in="${memberEligHistoryMap.keySet() }" status="idCount"
				var="memberDBID">
				 <g:each in="${memberEligHistoryMap.get(memberDBID)}" status="i"
						var="eligibilityHistoryVar">

				 	'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.entMcarePipdcgFactor' : {
						required : { 
							depends :function() { 																			        
						        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
						            return true;
						        }
						        return false;
						    }
						}
				 	},
					
				 	'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.pbp' : {
						required : { 
							depends :function() { 																			        
						        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
						            return true;
						        }
						        return false;
						    }
						}
				 	},

					'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.medicarePartAEffectDate' : {
						required : { 
							depends :function() { 																			        
						        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
						            return true;
						        }
						        return false;
						    }
						}
				 	},


				 	'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.geocode' : {
						required : { 
							depends :function() { 																			        
						        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
						            return true;
						        }
						        return false;
						    }
						}
				 	},

				 	'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.longTermInstFlag' : {
						required : { 
							depends :function() { 																			        
						        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
						            return true;
						        }
						        return false;
						    }
						}
				 	},

				 	'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.overrideFlag' : {
						required : { 
							depends :function() { 																			        
						        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
						            return true;
						        }
						        return false;
						    }
						}
				 	},

				 	'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.uiInitiatedChange' : {
						required : { 
							depends :function() { 																			        
						        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
						            return true;
						        }
						        return false;
						    }
						}
				 	},

				 	'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.uiUserDate' : {
						required : { 
							depends :function() { 																			        
						        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
						            return true;
						        }
						        return false;
						    }
						}
				 	},

				 	'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.applicationDateIndicator' : {
						required : { 
							depends :function() { 																			        
						        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
						            return true;
						        }
						        return false;
						    }
						}
				 	},

				 	'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.uiUserOrgDesignation' : {
						required : { 
							depends :function() { 																			        
						        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
						            return true;
						        }
						        return false;
						    }
						}
				 	},

				 	'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.newLisCostShareSubsidy' : {
						required : { 
							depends :function() { 																			        
						        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
						            return true;
						        }
						        return false;
						    }
						}
				 	},

				 	'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.premiumWithholdOption' : {
						required : { 
							depends :function() { 																			        
						        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
						            return true;
						        }
						        return false;
						    }
						}
				 	},

				 	'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.rxBin' : {
						required : { 
							depends :function() { 																			        
						        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
						            return true;
						        }
						        return false;
						    }
						}
				 	},

				 	'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.rxPcn' : {
						required : { 
							depends :function() { 																			        
						        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
						            return true;
						        }
						        return false;
						    }
						}
				 	},
				 	
				 	'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.thirdPartyId' : {
						required : { 
							depends :function() { 																			        
						        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
						            return true;
						        }
						        return false;
						    }
						}
				 	},

				 	'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.pbpSegmentNumber' : {
						required : { 
							depends :function() { 																			        
						        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
						            return true;
						        }
						        return false;
						    }
						}
				 	},

				 	'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.mmpOptOutFlag' : {
						required : { 
							depends :function() { 																			        
						        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
						            return true;
						        }
						        return false;
						    }
						}
				 	}
				 	<g:if test="${i < memberEligHistoryMap.get(memberDBID).size() && (i != memberEligHistoryMap.get(memberDBID).size()-1)}">
					,
				</g:if>
				</g:each>
				<g:if test="${i < memberEligHistoryMap.size() && (i != memberEligHistoryMap.size()-1)}">
				,
			</g:if>
			</g:each>
		</g:if>
	},
    messages : {
		<g:if test="${memberEligHistoryMap}">
			<g:each in="${memberEligHistoryMap.keySet() }" status="idCount"
				var="memberDBID">
				<g:each in="${memberEligHistoryMap.get(memberDBID)}" status="i"
					var="eligibilityHistoryVar">
				
						'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.entMcarePipdcgFactor' : {
							required : "Please enter a PIP-DCG"
						},
				
						'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.pbp' : {
							required : "Please enter a PBP"
						},

						'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.medicarePartAEffectDate' : {
							required : "Please enter a Medicare Part A Eff Dt"
						},

						'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.mcareStateCode' : {
							required : "Please enter a CMS State Cd"
						},
						
						'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.mcareCountyCode' : {
							required : "Please enter a CMS County Cd"
						},
						
						'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.geocode' : {
							required : "Please enter a Geo Code"
						},

						'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.longTermInstFlag' : {
							required : "Please enter a L T Inst  Flag"
						},

						'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.overrideFlag' : {
							required : "Please enter a Override Flag"
						},

						'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.uiInitiatedChange' : {
							required : "Please enter a UI Initiated"
						},

						'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.uiUserDate' : {
							required : "Please enter a UI User Date"
						},

						'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.applicationDateIndicator' : {
							required : "Please enter a Application Date Ind"
						},

						'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.uiUserOrgDesignation' : {
							required : "Please enter a UI User Org"
						},

						'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.newLisCostShareSubsidy' : {
							required : "Please enter a New LICSS"
						},

						'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.premiumWithholdOption' : {
							required : "Please enter a Premium Withhold Option"
						},

						'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.rxBin' : {
							required : "Please enter a RX BIN"
						},

						'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.rxPcn' : {
							required : "Please enter a RX PCN"
						},

						'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.thirdPartyId' : {
							required : "Please enter a Third Party Partner ID"
						},

						'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.pbpSegmentNumber' : {
							required : "Please enter a PBP Segment ID"
						},

						'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.mmpOptOutFlag' : {
							required : "Please enter a MMP-Opt out Flag"
						},
						
				</g:each>
			</g:each>
	 	</g:if>
	}
	
})
});

});
</script>

<script type="text/javascript">
		
			$(document).ready(function() {
		
				 $('.btnSaveAddress').hide();
		         // $('.btnResetddress').hide();  
		         $('.btnResetddressAlert').hide();  
		
		
		         $('.tablesorter').delegate('.btnEditAddress, .btnResetddress', 'click' ,function(){
		             var parentTR = $(this).closest('tr');
		             $(parentTR).find('.btnEditAddress').toggle();
		             $(parentTR).find('.btnSaveAddress').toggle();
		             $(parentTR).find('.btnResetddressAlert').toggle();
		             $(parentTR).nextUntil('tr:not(.tablesorter-childRow)').find('td').toggle();
		             $('#NewAddress').prop('disabled', function(i, v) { return !v; });
		
		
		             // $(this).closest('tr').nextUntil('tr:not(.tablesorter-childRow)').find('td').toggle();
		            //  return false;
		           });
		
		         $('.tablesorter').delegate('.btnSaveAddress', 'click' ,function(){
		             $('#editForm').submit();
		           });

		         $('.modal-footer').delegate('.btnResetddress', 'click' ,function(){
		        		this.form.reset();
		        		//document.forms['editForm'].reset()       		
		        		//$('#editForm').reset();
		              /*$('#editForm').each(function() {
		           	            this.reset();
		            	});*/
		        	});
		        	
		           
		           $( ".btnResetddress" ).click(function() {             
		             $('.btnEditAddress').show();
		             $('.btnSaveAddress').hide();
		             $('.btnResetddressAlert').hide();
		             $('.tablesorter-childRow').find('td').hide();
		              $('#NewAddress').prop('disabled', function(i, v) { return !v; });
		             // return false;
		           });
		
		
		           $( "#EffectiveDate, #TermDate, #EffectiveDate2, #TermDate2" ).datepicker({
		               numberOfMonths: 1,
		               showOn: "button",
		               buttonText: "<i class='fa fa-calendar'></i>",
		             });
		
		         
		
		
		             $('.btnResetddressAlert').click(function(e){ 
		               $('#WarningAlert').modal('show');
		             });
		
		             $('#WarningAlert').modal({
		               backdrop: 'static',
		               show: false
		             });
			
				/******************************************************************
			    Enable/Disable the name inputs (.FirstName and .LastName) 
			    when the checkbox (.UseMemberName)  is unchecked
			 *******************************************************************/
			 <%--   $('.FirstName, .LastName, .FirstName_r2_label, .FirstName_r2, .firstName').attr('disabled', 'disabled', 'disabled', 'disabled', 'disabled');
			
			   $('.UseMemberName').click(function(e) {
			       // var $this = $(this);
			       
			       if ( $(e.target).is(':checked') ) {
			         $('.FirstName, .LastName, .FirstName_r2_label, .FirstName_r2, .firstName').attr('disabled', 'disabled', 'disabled', 'disabled', 'disabled');                  
			       } else {
			         $('.FirstName, .LastName, .FirstName_r2_label, .FirstName_r2, .firstName').removeAttr( "disabled" );
			       }
			   }); --%>
			});
		
		</script>