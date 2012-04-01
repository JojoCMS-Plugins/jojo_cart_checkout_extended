<div style="float: left; width: 450px;">
            <h3>Shipping Address</h3>
            
            {if $OPTIONS.cart_billing_first=='yes'}<input type="checkbox" value="same" id="same_as_billing" onchange="if ($(this).attr('checked')) copyBillingToShipping();"/>
            <label for="same_as_billing">Same as my billing address</label><br /><div class="clear"></div>{/if}

            <label for="shipping_firstname">First name</label>
            <input type="text" size="20" name="shipping_firstname" maxlength="20" id="shipping_firstname" value="{if $fields.shipping_firstname}{$fields.shipping_firstname}{/if}" /> *<br />
{if $errors.shipping_firstname}<span class="error">{$errors.shipping_firstname}</span><br/>{/if}

            <label for="shipping_lastname">Last name</label>
            <input type="text" size="20" name="shipping_lastname" maxlength="20" id="shipping_lastname" value="{if $fields.shipping_lastname}{$fields.shipping_lastname}{/if}" /> *<br />
{if $errors.shipping_lastname}<span class="error">{$errors.shipping_lastname}</span><br/>{/if}

{if $OPTIONS.cart_use_company=='yes'}
            <label for="shipping_company">Company</label>
            <input type="text" size="20" name="shipping_company" maxlength="20" id="shipping_company" value="{if $fields.shipping_company}{$fields.shipping_company}{/if}" /><br />
{if $errors.shipping_company}<span class="error">{$errors.shipping_company}</span><br/>{/if}
{else}
<input type="hidden" name="shipping_company" id="shipping_company" value="{if $fields.shipping_company}{$fields.shipping_company}{/if}" />
{/if}

            <label for="shipping_email">Email</label>
            <input type="text" size="30" name="shipping_email" maxlength="85" id="shipping_email" value="{if $fields.shipping_email}{$fields.shipping_email}{/if}" /> *<br />
{if $errors.shipping_email}<span class="error">{$errors.shipping_email}</span><br/>{/if}

            <label for="shipping_phone">Phone</label>
            <input type="text" size="20" name="shipping_phone" maxlength="25" id="shipping_phone" value="{if $fields.shipping_phone}{$fields.shipping_phone}{/if}" />{if $OPTIONS.cart_phone_required=='yes'} *{/if}<br />
{if $errors.shipping_phone}<span class="error">{$errors.shipping_phone}</span><br/>{/if}

            <label for="shipping_country">Country</label>
            <select size="1" name="shipping_country" id="shipping_country" onchange="updateCountry($(this).val(), 'shipping');">
{assign var=found value=false}{foreach from=$countries item=c}
                <option value="{$c.code|strtoupper}"{if !$found && $c.code|strtoupper==$fields.shipping_country} selected="selected"{assign var=found value=true}{/if}>{$c.name}</option>
{/foreach}
            </select> *<br />
{if $errors.shipping_country}<span class="error">{$errors.shipping_country}</span><br/>{/if}

            <label for="shipping_state">State</label>
            <input type="text" size="20" name="shipping_state" maxlength="35" id="shipping_state" value="{if $fields.shipping_state}{$fields.shipping_state}{/if}" /><br />
{if $errors.shipping_state}<span class="error">{$errors.shipping_state}</span><br/>{/if}

            <label for="shipping_address1">Address 1</label>
            <input type="text" size="30" name="shipping_address1" maxlength="35" id="shipping_address1" value="{if $fields.shipping_address1}{$fields.shipping_address1}{/if}" /> *<br />
{if $errors.shipping_address1}<span class="error">{$errors.shipping_address1}</span><br/>{/if}

            <label for="shipping_address2">Address 2</label>
            <input type="text" size="30" name="shipping_address2" maxlength="35" id="shipping_address2" value="{if $fields.shipping_address2}{$fields.shipping_address2}{/if}" /><br />
{if $errors.shipping_address2}<span class="error">{$errors.shipping_address2}</span><br/>{/if}

            <label for="shipping_suburb">Suburb</label>
            <input type="text" size="20" name="shipping_suburb" maxlength="35" id="shipping_suburb" value="{if $fields.shipping_suburb}{$fields.shipping_suburb}{/if}" /><br />
{if $errors.shipping_suburb}<span class="error">{$errors.shipping_suburb}</span><br/>{/if}

            <label for="shipping_city">City</label>
            <input type="text" size="20" name="shipping_city" maxlength="35" id="shipping_city" value="{if $fields.shipping_city}{$fields.shipping_city}{/if}" /> *<br />
{if $errors.shipping_city}<span class="error">{$errors.shipping_city}</span><br/>{/if}

            <label for="shipping_postcode">Postcode</label>
            <input type="text" size="10" name="shipping_postcode" id="shipping_postcode" value="{if $fields.shipping_postcode}{$fields.shipping_postcode}{/if}" /> {if $required_fields.shipping_postcode}*{/if}<br />
{if $errors.shipping_postcode}<span class="error">{$errors.shipping_postcode}</span><br/>{/if}

{if $OPTIONS.cart_special == 'yes'}<label for="shipping_special">Special Instructions</label>
            <textarea rows="4" cols="40" name="shipping_special" id="shipping_special">{if $fields.shipping_special}{$fields.shipping_special}{/if}</textarea><br />
{if $errors.shipping_special}<span class="error">{$errors.shipping_special}</span><br/>{/if}{/if}
{jojoHook hook="jojo_cart_extra_fields"}{* deprecated: please use the shipping / billing hooks instead *}
{jojoHook hook="jojo_cart_extra_fields_shipping"}
        </div>