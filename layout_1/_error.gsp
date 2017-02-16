<!DOCTYPE html>
<html>
	<head>
		<title>Grails Runtime Exception</title>
		<meta name="layout" content="main">
	</head>
	<body>	
	<div id="fms_content">
      <div id="fms_content_header">
        <div class="fms_content_header_note">
        </div>
        <div class="fms_content_title">
          <h1>Unexpected Error</h1>
        </div>
      </div> 
		 <!-- START - Search Form -->
	<div class="fms_widget fms_form_container"> 
		
		<div id="fms_content_body">
		
          <div id="WidgetAboutInfo" class="fms_widget">
            <fieldset>
              <legend>
                <h2>Error</h2>
              </legend>          
				 <div class="alert alert-error" role="alert">
	                  <p class="control-label nowrap" id="AdminVersion_label">
	                  	<g:message code="error.message" default="We regret the inconvenience caused. This service is temporarily unavailable, please check with Customer Support for details." /> 
						<%--<g:renderException exception="${exception}" /> --%>
					</p>           
				</div>
              
            </fieldset>
          </div>
    
    </div>
    </div>
    </div>
	</body>
</html>