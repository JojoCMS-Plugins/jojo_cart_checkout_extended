{if $cartisempty}
    <h3>No items to check out!</h3>
    <p>Your shopping cart is empty, please add iems to your cart before proceeding to the checkout.</p>
    {jojoHook hook="jojo_cart_empty"}
{else}
<div class="jojo_cart">
{include file="jojo_cart_test_mode.tpl"}

{if !$fields.userid}
<div>Existing customers can <a href="login/cart/checkout/" rel="nofollow">login</a> to retrieve billing details.</div>
{/if}

{if $errors}
<div class="errors">
<p>Please correct the following errors before continuing</p>
<ul>
{foreach from=$errors key=key item=errorMsg}
{if is_numeric($key)}
  <li>{$errorMsg}</li>
{/if}
{/foreach}
</ul>
</div>
{/if}

<form method="post" action="cart/checkout/">
    <div class="box contact-form">
        <div style="float: left; width: 450px;">
            <h3>Shipping Address</h3>

            <label for="shipping_firstname">First name</label>
            <input type="text" size="20" name="shipping_firstname" maxlength="20" id="shipping_firstname" value="{if $fields.shipping_firstname}{$fields.shipping_firstname}{/if}" /> *<br />
{if $errors.shipping_firstname}<span class="error">{$errors.shipping_firstname}</span><br/>{/if}

            <label for="shipping_lastname">Last name</label>
            <input type="text" size="20" name="shipping_lastname" maxlength="20" id="shipping_lastname" value="{if $fields.shipping_lastname}{$fields.shipping_lastname}{/if}" /> *<br />
{if $errors.shipping_lastname}<span class="error">{$errors.shipping_lastname}</span><br/>{/if}

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
            <input type="text" size="10" name="shipping_postcode" id="shipping_postcode" value="{if $fields.shipping_postcode}{$fields.shipping_postcode}{/if}" /> *<br />
{if $errors.shipping_postcode}<span class="error">{$errors.shipping_postcode}</span><br/>{/if}

{if $OPTIONS.cart_special == 'yes'}<label for="shipping_special">Special Instructions</label>
            <textarea rows="4" cols="40" name="shipping_special" id="shipping_special">{$fields.shipping_special}</textarea><br />
{if $errors.shipping_special}<span class="error">{$errors.shipping_special}</span><br/>{/if}{/if}
{jojoHook hook="jojo_cart_extra_fields"}
        </div>

{if $OPTIONS.cart_billing == 'yes'}
        <div style="float: left; width: 450px;">
            <h3>Billing Address</h3>

            <input type="checkbox" value="same" id="same_as_shipping" onchange="if ($(this).attr('checked')) copyShippingToBilling();"/>
            <label for="same_as_shipping">Same as my shipping address</label><br />

            <label for="billing_firstname">First name</label>
            <input type="text" size="20" name="billing_firstname" maxlength="20" id="billing_firstname" value="{if $fields.billing_firstname}{$fields.billing_firstname}{/if}" /> *<br />
{if $errors.billing_firstname}<span class="error">{$errors.billing_firstname}</span><br/>{/if}

            <label for="billing_lastname">Last name</label>
            <input type="text" size="20" name="billing_lastname" maxlength="20" id="billing_lastname" value="{if $fields.billing_lastname}{$fields.billing_lastname}{/if}" /> *<br />
{if $errors.billing_lastname}<span class="error">{$errors.billing_lastname}</span><br/>{/if}

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
            <input type="text" size="10" name="billing_postcode" id="billing_postcode" value="{if $fields.billing_postcode}{$fields.billing_postcode}{/if}" /> *<br />
{if $errors.billing_postcode}<span class="error">{$errors.billing_postcode}</span><br/>{/if}

{jojoHook hook="jojo_cart_extra_fields"}
        </div>

{/if}

{if !$fields.userid && !($OPTIONS.cart_create_account =='no')}
<div style="float: left; width: 450px;">
            <h3>Save your details</h3>
            <label for="create_account">Create account</label>
            <div class="form-field">
                <label><input type="checkbox" name="create_account" id="create_account" value="1" /> Create a user account to speed up ordering next time?</label><br />
            </div>
            <div id="register" style="clear:left">
                    <label for="username">User name</label>
                    <input type="text" size="10" name="username" id="username" value="{if $fields.username}{$fields.username}{/if}" /> *<br />

                    <label for="password">Password</label>
                    <input type="text" size="10" name="password" id="password" value="{if $fields.password}{$fields.password}{/if}" /> *<br />

                    <label for="password_confirm">Confirm Password</label>
                    <input type="text" size="10" name="password" id="password" value="{if $fields.password}{$fields.password}{/if}" /> *<br />
                </div>
                <script type="text/javascript">
                /*<![CDATA[*/
                {literal}$(document).ready(function(){
                  $('#register').hide();
                  $('#create_account').click(function(){
                    if ($("#create_account:checked").val()) {
                      $('#register').show('normal');
                    } else {
                      $('#register').hide('normal');
                    }
                  });
                });{/literal}
                /*]]>*/
                </script>
</div>
{/if}
        <br style="clear: both" />
        <input type="submit" name="continue" value="Continue"/>
    </div>
</form>
</div>

<script type='text/javascript'>
/*<![CDATA[*/
{literal}    updateCountry($('#billing_country').val(),  'billing');
    updateCountry($('#shipping_country').val(), 'shipping');{/literal}
/*]]>*/
</script>
{/if}