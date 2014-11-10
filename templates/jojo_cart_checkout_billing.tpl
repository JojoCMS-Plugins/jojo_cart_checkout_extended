<fieldset id="billing-details">
    <legend>Billing Address{if $OPTIONS.cart_billing_first!='yes'} &nbsp;<a class="button btn btn-small" href="#" onclick="copyShippingToBilling(); return false;">Copy from Shipping Address</a>{/if}</legend>

    <div class="form-fieldset form-group{if $errors.billing_firstname} has-error{/if}">
        <label for="billing_firstname">First name<span class="required">*</span></label>
        <input type="text" class="form-control input text required" size="20" name="billing_firstname" maxlength="20" id="billing_firstname" value="{if $fields.billing_firstname}{$fields.billing_firstname}{/if}" />
    </div>

    <div class="form-fieldset form-group{if $errors.billing_lastname} has-error{/if}">
        <label for="billing_lastname">Last name<span class="required">*</span></label>
        <input type="text" class="form-control input text required" size="20" name="billing_lastname" maxlength="20" id="billing_lastname" value="{if $fields.billing_lastname}{$fields.billing_lastname}{/if}" />
    </div>

    <div class="form-fieldset form-group{if $errors.billing_company} has-error{/if}">
{if $OPTIONS.cart_use_company=='yes'}
        <label for="billing_company">Company</label>
        <input type="text" class="form-control input text" size="20" name="billing_company" maxlength="20" id="billing_company" value="{if $fields.billing_company}{$fields.billing_company}{/if}" />
{if $errors.billing_company}<span class="error">{$errors.billing_company}</span><br/>{/if}
{else}
<input type="hidden" name="billing_company" id="billing_company" value="{if $fields.billing_company}{$fields.billing_company}{/if}" />
{/if}
    </div>

    <div class="form-fieldset form-group{if $errors.billing_email} has-error{/if}">
        <label for="billing_email">Email<span class="required">*</span></label>
        <input type="email" class="form-control input email required" size="30" name="billing_email" maxlength="85" id="billing_email" value="{if $fields.billing_email}{$fields.billing_email}{/if}" />
    </div>

    <div class="form-fieldset form-group{if $errors.billing_phone} has-error{/if}">
        <label for="billing_phone">Phone{if $OPTIONS.cart_phone_required=='yes'}<span class="required">*</span>{/if}</label>
        <input type="text" class="form-control input text{if $OPTIONS.cart_phone_required=='yes'} required{/if}" size="20" name="billing_phone" maxlength="25" id="billing_phone" value="{if $fields.billing_phone}{$fields.billing_phone}{/if}" />
    </div>

    <div class="form-fieldset form-group{if $errors.billing_country} has-error{/if}">
        <label for="billing_country" class="control-label">Country<span class="required">*</span></label>
        <select class="form-control select required" name="billing_country" id="billing_country" onchange="updateCountry($(this).val(), 'billing');">{assign var=found value=false}
            {foreach from=$countries item=country}<option value="{$country.code|strtoupper}"{if !$found && $country.code|strtoupper==$fields.billing_country } selected="selected"{assign var=found value=true}{/if}>{$country.name}</option>
            {/foreach}
        </select>
    </div>

    <div class="form-fieldset form-group{if $errors.billing_state} has-error{/if}">
        <label for="billing_state">State</label>
        <input type="text" class="form-control input text" size="20" name="billing_state" maxlength="35" id="billing_state" value="{if $fields.billing_state}{$fields.billing_state}{/if}" />
    </div>

    <div class="form-fieldset form-group{if $errors.billing_address1} has-error{/if}">
        <label for="billing_address1">Address 1<span class="required">*</span></label>
        <input type="text" class="form-control input text required" size="30" name="billing_address1" maxlength="35" id="billing_address1" value="{if $fields.billing_address1}{$fields.billing_address1}{/if}" />
    </div>

    <div class="form-fieldset form-group{if $errors.billing_address2} has-error{/if}">
        <label for="billing_address2">Address 2</label>
        <input type="text" class="form-control input text" size="30" name="billing_address2" maxlength="35" id="billing_address2" value="{if $fields.billing_address2}{$fields.billing_address2}{/if}" />
    </div>

    <div class="form-fieldset form-group{if $errors.billing_suburb} has-error{/if}">
        <label for="billing_suburb">Suburb</label>
        <input type="text" class="form-control input text" size="20" name="billing_suburb" maxlength="35" id="billing_suburb" value="{if $fields.billing_suburb}{$fields.billing_suburb}{/if}" />
    </div>

    <div class="form-fieldset form-group{if $errors.billing_city} has-error{/if}">
        <label for="billing_city">City<span class="required">*</span></label>
        <input type="text" class="form-control input text required" size="20" name="billing_city" maxlength="35" id="billing_city" value="{if $fields.billing_city}{$fields.billing_city}{/if}" />
    </div>

    <div class="form-fieldset form-group{if $errors.billing_postcode} has-error{/if}">
        <label for="billing_postcode">Postcode{if $required_fields.billing_postcode}<span class="required">*</span>{/if}</label>
        <input type="text" class="form-control input text{if $required_fields.billing_postcode} required{/if}" size="10" name="billing_postcode" id="billing_postcode" value="{if $fields.billing_postcode}{$fields.billing_postcode}{/if}" />
    </div>

{jojoHook hook="jojo_cart_extra_fields"}{* deprecated: please use the shipping / billing hooks instead *}
{jojoHook hook="jojo_cart_extra_fields_billing"}
</fieldset>