<!DOCTYPE html>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="petclinic" tagdir="/WEB-INF/tags" %>


<html lang="en">

<jsp:include page="../fragments/headTag.jsp"/>


<script language="JavaScript">
    function validateField(fieldName, fieldValue, minLength, maxLength, errorMessageId, regex, regexDesc) {
        if (fieldValue == null || fieldValue.trim() == "") {
            document.getElementById('error_messages').innerHTML = "Please enter " + fieldName;
            return false;
        }
        if (fieldValue.length > maxLength || fieldValue.length < minLength) {
            if(minLength == maxLength){
                document.getElementById('error_messages').innerHTML = fieldName + " must be " + maxLength + " chars";
            }else {
                document.getElementById('error_messages').innerHTML = fieldName + " must be between " + minLength + " and " + maxLength + " chars";
            }
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
        var firstName = myform.firstName.value;
        var lastName = myform.lastName.value;
        var address = myform.address.value;
        var city = myform.city.value;
        var telephone = myform.telephone.value;
        var nameRegex = /^[a-zA-Z\s]*$/;
        var nameRegexDesc = "alphabets or spaces";
        var phoneRegex = /^[0-9\s]*$/;
        var phoneRegexDesc = "numbers or spaces";
        var errorMessagesId = "error_messages";
        //
        var valid = validateField("First Name", firstName, 5, 30, errorMessagesId, nameRegex, nameRegexDesc);
        if(valid){
            valid = validateField("Last Name", lastName, 5, 30, errorMessagesId, nameRegex, nameRegexDesc);
        }
        if(valid){
            valid = validateField("Address", address, 30, 255, errorMessagesId);
        }
        if(valid){
            valid = validateField("City", city, 2, 80, errorMessagesId, nameRegex, nameRegexDesc);
        }
        if(valid){
            valid = validateField("Telephone", telephone, 11, 11, errorMessagesId, phoneRegex, phoneRegexDesc);
        }
        return valid;
    }
</script>

<body>
<div class="container">
    <jsp:include page="../fragments/bodyHeader.jsp"/>
    <c:choose>
        <c:when test="${owner['new']}"><c:set var="method" value="post"/></c:when>
        <c:otherwise><c:set var="method" value="put"/></c:otherwise>
    </c:choose>

    <h2>
        <c:if test="${owner['new']}">New </c:if> Owner
    </h2>
    <span id="error_messages" style="color:red;">&nbsp;</span>
    <form:form modelAttribute="owner" method="${method}" class="form-horizontal" id="add-owner-form" onsubmit="return validateForm();">
        <petclinic:inputField label="First Name" name="firstName"/>
        <petclinic:inputField label="Last Name" name="lastName"/>
        <petclinic:inputField label="Address" name="address"/>
        <petclinic:inputField label="City" name="city"/>
        <petclinic:inputField label="Telephone" name="telephone"/>

        <div class="form-actions">
            <c:choose>
                <c:when test="${owner['new']}">
                    <button type="submit">Add Owner</button>
                </c:when>
                <c:otherwise>
                    <button type="submit">Update Owner</button>
                </c:otherwise>
            </c:choose>
        </div>
    </form:form>
</div>
<jsp:include page="../fragments/footer.jsp"/>
</body>


</html>
