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
            <input type="text" size="20" name="shipping_firstname" id="shipping_firstname" value="{$fields.shipping_firstname}" /> *<br />
{if $errors.shipping_firstname}<span class="error">{$errors.shipping_firstname}</span><br/>{/if}

            <label for="shipping_lastname">Last name</label>
            <input type="text" size="20" name="shipping_lastname" id="shipping_lastname" value="{$fields.shipping_lastname}" /> *<br />
{if $errors.shipping_lastname}<span class="error">{$errors.shipping_lastname}</span><br/>{/if}

            <label for="shipping_email">Email</label>
            <input type="text" size="30" name="shipping_email" id="shipping_email" value="{$fields.shipping_email}" /> *<br />
{if $errors.shipping_email}<span class="error">{$errors.shipping_email}</span><br/>{/if}

            <label for="shipping_country">Country</label>
            <select size="1" name="shipping_country" id="shipping_country" onchange="updateCountry($(this).val(), 'shipping');">
{assign var=found value=false}{section name=c loop=$countries}
                <option value="{$countries[c].code|strtoupper}"{if !$found && $countries[c].code|strtoupper==$fields.shipping_country} selected="selected"{assign var=found value=true}{/if}>{$countries[c].name}</option>
{/section}
            </select> *<br />
{if $errors.shipping_country}<span class="error">{$errors.shipping_country}</span><br/>{/if}

            <label for="shipping_state">State</label>
            <input type="text" size="20" name="shipping_state" id="shipping_state" value="{$fields.shipping_state}" /><br />
{if $errors.shipping_state}<span class="error">{$errors.shipping_state}</span><br/>{/if}

            <label for="shipping_address1">Address 1</label>
            <input type="text" size="30" name="shipping_address1" id="shipping_address1" value="{$fields.shipping_address1}" /> *<br />
{if $errors.shipping_address1}<span class="error">{$errors.shipping_address1}</span><br/>{/if}

            <label for="shipping_address2">Address 2</label>
            <input type="text" size="30" name="shipping_address2" id="shipping_address2" value="{$fields.shipping_address2}" /><br />
{if $errors.shipping_address2}<span class="error">{$errors.shipping_address2}</span><br/>{/if}

            <label for="shipping_suburb">Suburb</label>
            <input type="text" size="20" name="shipping_suburb" id="shipping_suburb" value="{$fields.shipping_suburb}" /><br />
{if $errors.shipping_suburb}<span class="error">{$errors.shipping_suburb}</span><br/>{/if}

            <label for="shipping_city">City</label>
            <input type="text" size="20" name="shipping_city" id="shipping_city" value="{$fields.shipping_city}" /> *<br />
{if $errors.shipping_city}<span class="error">{$errors.shipping_city}</span><br/>{/if}

            <label for="shipping_postcode">Postcode</label>
            <input type="text" size="10" name="shipping_postcode" id="shipping_postcode" value="{$fields.shipping_postcode}" /> *<br />
{if $errors.shipping_postcode}<span class="error">{$errors.shipping_postcode}</span><br/>{/if}
        </div>

        <div style="float: left; width: 450px;">
            <h3>Billing Address</h3>

            <input type="checkbox" value="same" id="same_as_shipping" onchange="if ($(this).attr('checked')) copyShippingToBilling();"/>
            <label for="same_as_shipping">Same as my shipping address</label><br />

            <label for="billing_firstname">First name</label>
            <input type="text" size="20" name="billing_firstname" id="billing_firstname" value="{$fields.billing_firstname}" /> *<br />
{if $errors.billing_firstname}<span class="error">{$errors.billing_firstname}</span><br/>{/if}

            <label for="billing_lastname">Last name</label>
            <input type="text" size="20" name="billing_lastname" id="billing_lastname" value="{$fields.billing_lastname}" /> *<br />
{if $errors.billing_lastname}<span class="error">{$errors.billing_lastname}</span><br/>{/if}

            <label for="billing_email">Email</label>
            <input type="text" size="30" name="billing_email" id="billing_email" value="{$fields.billing_email}" /> *<br />
{if $errors.billing_email}<span class="error">{$errors.billing_email}</span><br/>{/if}

            <label for="billing_country">Country</label>
            <select size="1" name="billing_country" id="billing_country" onchange="updateCountry($(this).val(), 'billing');">
{assign var=found value=false}{section name=c loop=$countries}
                <option value="{$countries[c].code|strtoupper}"{if !$found && $countries[c].code|strtoupper==$fields.billing_country} selected="selected"{assign var=found value=true}{/if}>{$countries[c].name}</option>
{/section}
            </select> *<br />
{if $errors.billing_country}<span class="error">{$errors.billing_country}</span><br/>{/if}

            <label for="billing_state">State</label>
            <input type="text" size="20" name="billing_state" id="billing_state" value="{$fields.billing_state}" /><br />
{if $errors.billing_state}<span class="error">{$errors.billing_state}</span><br/>{/if}

            <label for="billing_address1">Address 1</label>
            <input type="text" size="30" name="billing_address1" id="billing_address1" value="{$fields.billing_address1}" /> *<br />
{if $errors.billing_address1}<span class="error">{$errors.billing_address1}</span><br/>{/if}

            <label for="billing_address2">Address 2</label>
            <input type="text" size="30" name="billing_address2" id="billing_address2" value="{$fields.billing_address2}" /><br />
{if $errors.billing_address2}<span class="error">{$errors.billing_address2}</span><br/>{/if}

            <label for="billing_suburb">Suburb</label>
            <input type="text" size="20" name="billing_suburb" id="billing_suburb" value="{$fields.billing_suburb}" /><br />
{if $errors.billing_suburb}<span class="error">{$errors.billing_suburb}</span><br/>{/if}

            <label for="billing_city">City</label>
            <input type="text" size="20" name="billing_city" id="billing_city" value="{$fields.billing_city}" /> *<br />
{if $errors.billing_city}<span class="error">{$errors.billing_city}</span><br/>{/if}

            <label for="billing_postcode">Postcode</label>
            <input type="text" size="10" name="billing_postcode" id="billing_postcode" value="{$fields.billing_postcode}" /> *<br />
{if $errors.billing_postcode}<span class="error">{$errors.billing_postcode}</span><br/>{/if}

        </div>
{jojoHook hook="jojo_cart_extra_fields"}

{if !$fields.userid}
            <h3>Save your details</h3>
            <label for="create_account">Create account</label>
            <div class="form-field">
                <label><input type="checkbox" name="create_account" id="create_account" value="1" /> Create a user account to speed up ordering next time?</label><br />
            </div>
            <div id="register" style="clear:left">
                    <label for="username">User name</label>
                    <input type="text" size="10" name="username" id="username" value="{$fields.username}" /> *<br />
                    
                    <label for="password">Password</label>
                    <input type="text" size="10" name="password" id="password" value="{$fields.password}" /> *<br />
                    
                    <label for="password_confirm">Confirm Password</label>
                    <input type="text" size="10" name="password" id="password" value="{$fields.password}" /> *<br />
                </div>
                <script type="text/javascript">
                {literal}$(document).ready(function(){
                  $('#register').hide();
                  $('#create_account').click(function(){
                    //if ($('#create_account').attr('checked') == 'checked') {
                    if ($("#create_account:checked").val()) {
                      $('#register').show('normal');
                    } else {
                      $('#register').hide('normal');
                    }
                  });
                });{/literal}
                </script>
{/if}
        <br style="clear: both" />
        <input type="submit" name="continue" value="Continue"/>
    </div>
</form>
</div>

<script type='text/javascript'>{literal}
    updateCountry($('#billing_country').val(),  'billing');
    updateCountry($('#shipping_country').val(), 'shipping');
{/literal}</script>
{/if}