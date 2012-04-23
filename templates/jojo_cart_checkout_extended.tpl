{if $cartisempty}
    <h3>No items to check out!</h3>
    <p>Your shopping cart is empty, please add iems to your cart before proceeding to the checkout.</p>
    {jojoHook hook="jojo_cart_empty"}
{else}
<div class="jojo_cart">
{include file="jojo_cart_test_mode.tpl"}

{if !$fields.userid}
<div id="existing_customers_login">Existing customers can <a href="login/cart/checkout/" rel="nofollow">login</a> to retrieve billing details.</div>
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
        {if $OPTIONS.cart_billing_first!='yes'}{include file="jojo_cart_checkout_shipping.tpl"}{/if}
        {if $OPTIONS.cart_billing == 'yes'}{include file="jojo_cart_checkout_billing.tpl"}{/if}
        {if $OPTIONS.cart_billing_first=='yes'}{include file="jojo_cart_checkout_shipping.tpl"}{/if}


{if !$fields.userid && !($OPTIONS.cart_create_account =='no')}
<div style="float: left; width: 450px;">
            <h3>Save your details</h3>
            <label for="create_account">Create account</label>
            <div class="form-field">
                <label><input type="checkbox" name="create_account" id="create_account" value="1"{if $smarty.post.create_account == 1} checked="checked"{/if} /> Create a user account to speed up ordering next time?</label><br />
            </div>
            <div id="register" style="clear:left">
                    <label for="username">User name</label>
                    <input type="text" size="10" name="username" id="username" value="{if $fields.username}{$fields.username}{/if}" /> *<br />

                    <label for="password">Password</label>
                    <input type="password" size="10" name="password" id="password" value="{if $fields.password}{$fields.password}{/if}" /> *<br />

                    <label for="password_confirm">Confirm Password</label>
                    <input type="password" size="10" name="confirm_password" id="password" value="{if $fields.password}{$fields.password}{/if}" /> *<br />
                    
                    <label for="remember_password">Remember password</label>
                    <input type="checkbox" name="remember_password" id="remember_password" value="1" {if $smarty.post.remember_password == 1} checked="checked"{/if} /> (on this computer)<br />
                </div>
                <script type="text/javascript">
                /*<![CDATA[*/
                {literal}$(document).ready(function(){
                  {/literal}{if $smarty.post.create_account == 1}//{/if}{literal}$('#register').hide();
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