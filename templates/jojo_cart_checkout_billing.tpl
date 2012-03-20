<div style="float: left; width: 450px;">
            <h3>Billing Address</h3>

            {if $OPTIONS.cart_billing_first!='yes'}<input type="checkbox" value="same" id="same_as_shipping" onchange="if ($(this).attr('checked')) copyShippingToBilling();"/>
            <label for="same_as_shipping">Same as my shipping address</label><br /><div class="clear"></div>{/if}

            <label for="billing_firstname">First name</label>
            <input type="text" size="20" name="billing_firstname" maxlength="20" id="billing_firstname" value="{if $fields.billing_firstname}{$fields.billing_firstname}{/if}" /> *<br />
{if $errors.billing_firstname}<span class="error">{$errors.billing_firstname}</span><br/>{/if}

            <label for="billing_lastname">Last name</label>
            <input type="text" size="20" name="billing_lastname" maxlength="20" id="billing_lastname" value="{if $fields.billing_lastname}{$fields.billing_lastname}{/if}" /> *<br />
{if $errors.billing_lastname}<span class="error">{$errors.billing_lastname}</span><br/>{/if}

{if $OPTIONS.cart_use_company=='yes'}
            <label for="billing_company">Company</label>
            <input type="text" size="20" name="billing_company" maxlength="20" id="billing_company" value="{if $fields.billing_company}{$fields.billing_company}{/if}" /><br />
{if $errors.billing_company}<span class="error">{$errors.billing_company}</span><br/>{/if}
{else}
<input type="hidden" name="billing_company" id="billing_company" value="{if $fields.billing_company}{$fields.billing_company}{/if}" />
{/if}

            <label for="billing_email">Email</label>
            <input type="text" size="30" name="billing_email" maxlength="85" id="billing_email" value="{if $fields.billing_email}{$fields.billing_email}{/if}" /> *<br />
{if $errors.billing_email}<span class="error">{$errors.billing_email}</span><br/>{/if}

            <label for="billing_phone">Phone</label>
            <input type="text" size="20" name="billing_phone" maxlength="25" id="billing_phone" value="{if $fields.billing_phone}{$fields.billing_phone}{/if}" />{if $OPTIONS.cart_phone_required=='yes'} *{/if}<br />
{if $errors.billing_phone}<span class="error">{$errors.billing_phone}</span><br/>{/if}

            <label for="billing_country">Country</label>
            <select size="1" name="billing_country" maxlength="35" id="billing_country" onchange="updateCountry($(this).val(), 'billing');">
{assign var=found value=false}{foreach from=$countries item=c}
                <option value="{$c.code|strtoupper}"{if !$found && $c.code|strtoupper==$fields.billing_country} selected="selected"{assign var=found value=true}{/if}>{$c.name}</option>
{/foreach}
            </select> *<br />
{if $errors.billing_country}<span class="error">{$errors.billing_country}</span><br/>{/if}

            <label for="billing_state">State</label>
            <input type="text" size="20" name="billing_state" maxlength="35" id="billing_state" value="{if $fields.billing_state}{$fields.billing_state}{/if}" /><br />
{if $errors.billing_state}<span class="error">{$errors.billing_state}</span><br/>{/if}

            <label for="billing_address1">Address 1</label>
            <input type="text" size="30" name="billing_address1" maxlength="35" id="billing_address1" value="{if $fields.billing_address1}{$fields.billing_address1}{/if}" /> *<br />
{if $errors.billing_address1}<span class="error">{$errors.billing_address1}</span><br/>{/if}

            <label for="billing_address2">Address 2</label>
            <input type="text" size="30" name="billing_address2" maxlength="35" id="billing_address2" value="{if $fields.billing_address2}{$fields.billing_address2}{/if}" /><br />
{if $errors.billing_address2}<span class="error">{$errors.billing_address2}</span><br/>{/if}

            <label for="billing_suburb">Suburb</label>
            <input type="text" size="20" name="billing_suburb" maxlength="35" id="billing_suburb" value="{if $fields.billing_suburb}{$fields.billing_suburb}{/if}" /><br />
{if $errors.billing_suburb}<span class="error">{$errors.billing_suburb}</span><br/>{/if}

            <label for="billing_city">City</label>
            <input type="text" size="20" name="billing_city" maxlength="35" id="billing_city" value="{if $fields.billing_city}{$fields.billing_city}{/if}" /> *<br />
{if $errors.billing_city}<span class="error">{$errors.billing_city}</span><br/>{/if}

            <label for="billing_postcode">Postcode</label>
            <input type="text" size="10" name="billing_postcode" id="billing_postcode" value="{if $fields.billing_postcode}{$fields.billing_postcode}{/if}" /> {if $required_fields.billing_postcode}*{/if}<br />
{if $errors.billing_postcode}<span class="error">{$errors.billing_postcode}</span><br/>{/if}

{jojoHook hook="jojo_cart_extra_fields"}{* deprecated: please use the shipping / billing hooks instead *}
{jojoHook hook="jojo_cart_extra_fields_billing"}
        </div>