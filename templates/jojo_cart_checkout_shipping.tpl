<fieldset id="shipping-details">
    <legend>Shipping Address{if $OPTIONS.cart_billing_first=='yes'} &nbsp;<a class="button btn btn-small" href="#" onclick="copyBillingToShipping(); return false;">Copy from Billing Address</a>{/if}</legend>

    <div class="form-fieldset form-group{if $errors.shipping_firstname} has-error{/if}">
        <label for="shipping_firstname">First name<span class="required">*</span></label>
        <input type="text" class="form-control input text required" size="20" name="shipping_firstname" maxlength="20" id="shipping_firstname" value="{if $fields.shipping_firstname}{$fields.shipping_firstname}{/if}" />
    </div>

    <div class="form-fieldset form-group{if $errors.shipping_lastname} has-error{/if}">
        <label for="shipping_lastname">Last name<span class="required">*</span></label>
        <input type="text" class="form-control input text required" size="20" name="shipping_lastname" maxlength="20" id="shipping_lastname" value="{if $fields.shipping_lastname}{$fields.shipping_lastname}{/if}" />
    </div>

{if $OPTIONS.cart_use_company=='yes'}
     <div class="form-fieldset form-group{if $errors.shipping_company} has-error{/if}">
        <label for="shipping_company">Company</label>
        <input type="text" class="form-control input text" size="20" name="shipping_company" maxlength="20" id="shipping_company" value="{if $fields.shipping_company}{$fields.shipping_company}{/if}" />
    </div>
{else}
<input type="hidden" name="shipping_company" id="shipping_company" value="{if $fields.shipping_company}{$fields.shipping_company}{/if}" />
{/if}

    <div class="form-fieldset form-group{if $errors.shipping_email} has-error{/if}">
        <label for="shipping_email">Email<span class="required">*</span></label>
        <input type="email" class="form-control input email required" size="30" name="shipping_email" maxlength="85" id="shipping_email" value="{if $fields.shipping_email}{$fields.shipping_email}{/if}" />
    </div>

    <div class="form-fieldset form-group{if $errors.shipping_phone} has-error{/if}">
        <label for="shipping_phone">Phone{if $OPTIONS.cart_phone_required=='yes'}<span class="required">*</span>{/if}</label>
        <input type="text" class="form-control input text{if $OPTIONS.cart_phone_required=='yes'} required{/if}" size="20" name="shipping_phone" maxlength="25" id="shipping_phone" value="{if $fields.shipping_phone}{$fields.shipping_phone}{/if}" />
    </div>

    <div class="form-fieldset form-group{if $errors.shipping_country} has-error{/if}">
        <label for="shipping_country" class="control-label">Country<span class="required">*</span></label>
        <select class="form-control select required" name="shipping_country" id="shipping_country" onchange="updateCountry($(this).val(), 'shipping');">{assign var=found value=false}
            {if $shippingcountries}{foreach from=$shippingcountries item=country}<option value="{$country.code|strtoupper}"{if !$found && $country.code|strtoupper==$fields.shipping_country } selected="selected"{assign var=found value=true}{/if}>{$country.name}</option>
            {/foreach}{else}{foreach from=$countries item=country}<option value="{$country.code|strtoupper}"{if !$found && $country.code|strtoupper==$fields.shipping_country } selected="selected"{assign var=found value=true}{/if}>{$country.name}</option>
            {/foreach}{/if}
        </select>
    </div>

    <div class="form-fieldset form-group{if $errors.shipping_state} has-error{/if}">
        <label for="shipping_state">State</label>
        <input type="text" class="form-control input text" size="20" name="shipping_state" maxlength="35" id="shipping_state" value="{if $fields.shipping_state}{$fields.shipping_state}{/if}" />
    </div>

    <div class="form-fieldset form-group{if $errors.shipping_address1} has-error{/if}">
        <label for="shipping_address1">Address 1<span class="required">*</span></label>
        <input type="text" class="form-control input text required" size="30" name="shipping_address1" maxlength="35" id="shipping_address1" value="{if $fields.shipping_address1}{$fields.shipping_address1}{/if}" />
    </div>

    <div class="form-fieldset form-group{if $errors.shipping_address2} has-error{/if}">
        <label for="shipping_address2">Address 2</label>
        <input type="text" class="form-control input text" size="30" name="shipping_address2" maxlength="35" id="shipping_address2" value="{if $fields.shipping_address2}{$fields.shipping_address2}{/if}" />
    </div>

    <div class="form-fieldset form-group{if $errors.shipping_suburb} has-error{/if}">
        <label for="shipping_suburb">Suburb</label>
        <input type="text" class="form-control input text" size="20" name="shipping_suburb" maxlength="35" id="shipping_suburb" value="{if $fields.shipping_suburb}{$fields.shipping_suburb}{/if}" />
    </div>

    <div class="form-fieldset form-group{if $errors.shipping_city} has-error{/if}">
        <label for="shipping_city">City<span class="required">*</span></label>
        <input type="text" class="form-control input text required" size="20" name="shipping_city" maxlength="35" id="shipping_city" value="{if $fields.shipping_city}{$fields.shipping_city}{/if}" />
    </div>

    <div class="form-fieldset form-group{if $errors.shipping_postcode} has-error{/if}">
        <label for="shipping_postcode">Postcode{if $required_fields.shipping_postcode}<span class="required">*</span>{/if}</label>
        <input type="text" class="form-control input text{if $required_fields.shipping_postcode} required{/if}" size="10" name="shipping_postcode" id="shipping_postcode" value="{if $fields.shipping_postcode}{$fields.shipping_postcode}{/if}" />
    </div>

    <div class="form-fieldset form-group{if $errors.shipping_special} has-error{/if}">
{if $OPTIONS.cart_special == 'yes'}<label for="shipping_special">Special Instructions</label>
        <textarea class="form-control input text" rows="4" cols="40" name="shipping_special" id="shipping_special">{if $fields.shipping_special}{$fields.shipping_special}{/if}</textarea>
    </div>
{jojoHook hook="jojo_cart_extra_fields"}{* deprecated: please use the shipping / billing hooks instead *}
{jojoHook hook="jojo_cart_extra_fields_shipping"}
</fieldset>