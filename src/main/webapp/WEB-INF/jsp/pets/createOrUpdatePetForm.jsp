<!DOCTYPE html> 

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="petclinic" tagdir="/WEB-INF/tags" %>


<html lang="en">

<jsp:include page="../fragments/headTag.jsp"/>

<script src="/petdoctor/resources/js/moment.js"></script>



<script language="JavaScript">
    function validateField(fieldName, fieldValue, minLength, maxLength, errorMessageId, regex, regexDesc) {
        if (fieldValue == null || fieldValue.trim() == "") {
            document.getElementById('error_messages').innerHTML = "Please enter " + fieldName;
            return false;
        }
        if (fieldValue.length > maxLength || fieldValue.length < minLength) {
            document.getElementById('error_messages').innerHTML = fieldName + " must be between "+minLength+" and "+maxLength+" chars";
            return false;
        }
        if(regex != undefined) {
            if (!regex.test(fieldValue)) {
                document.getElementById('error_messages').innerHTML = fieldName + " must contain only "+regexDesc;
                return false;
            }
        }
        return true;
    }

    function validateForm() {
        var myform = document.forms[0];
        var name = myform.name.value;
        var birthDate = myform.birthDate.value;
        var type = myform.type.value;
        var nameRegex = /^[a-zA-Z\s]*$/;
        var nameRegexDesc = "alphabets or spaces";
        var errorMessagesId = "error_messages";
        //
        var valid = validateField("Name", name, 5, 30, errorMessagesId, nameRegex, nameRegexDesc);
        if(valid){
            valid = moment(birthDate, 'YYYY/MM/DD',true).isValid();
            if(!valid){
                document.getElementById('error_messages').innerHTML = "Please enter a valid Birth Date in YYYY/MM/DD format";
            }

            if(valid){
                var today = new Date();
                var bDate = moment(birthDate, "YYYY/MM/DD");
                if(bDate > today){
                    document.getElementById('error_messages').innerHTML = "Birth Date cannot be future";
                    valid = false;
                }
            }
        }
        if(valid){
            if(type == '' || type == undefined ){
                document.getElementById('error_messages').innerHTML = "Please select Type";
                valid = false;
            }
        }
        return valid;
    }
</script>


<body>

<script>
    $(function () {
        $("#birthDate").datepicker({ dateFormat: 'yy/mm/dd'});
    });
</script>
<div class="container">
    <jsp:include page="../fragments/bodyHeader.jsp"/>
    <c:choose>
        <c:when test="${pet['new']}">
            <c:set var="method" value="post"/>
        </c:when>
        <c:otherwise>
            <c:set var="method" value="put"/>
        </c:otherwise>
    </c:choose>

    <h2>
        <c:if test="${pet['new']}">New </c:if>
        Pet
    </h2>

    <span id="error_messages" style="color:red;">&nbsp;</span>

    <form:form modelAttribute="pet" method="${method}"
               class="form-horizontal" onsubmit="return validateForm()">
        <div class="control-group" id="owner">
            <label class="control-label">Owner </label>

            <c:out value="${pet.owner.firstName} ${pet.owner.lastName}"/>
        </div>
        <petclinic:inputField label="Name" name="name"/>
        <petclinic:inputField label="Birth Date" name="birthDate"/>
        <div class="control-group">
            <petclinic:selectField name="type" label="Type " names="${types}" size="5"/>
        </div>
        <div class="form-actions">
            <c:choose>
                <c:when test="${pet['new']}">
                    <button type="submit">Add Pet</button>
                </c:when>
                <c:otherwise>
                    <button type="submit">Update Pet</button>
                </c:otherwise>
            </c:choose>
        </div>
    </form:form>
    <c:if test="${!pet['new']}">
    </c:if>
    <jsp:include page="../fragments/footer.jsp"/>
</div>
</body>

</html>
