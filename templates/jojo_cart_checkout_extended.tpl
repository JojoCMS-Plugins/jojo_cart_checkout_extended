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
  <li>{$errorMsg}</li>
{/foreach}
</ul>
</div>
{/if}

<form id="customer-details" method="post" action="cart/checkout/"  class="contact-form no-ajax" role="form">
    {if $OPTIONS.cart_billing_first!='yes'}{include file="jojo_cart_checkout_shipping.tpl"}{/if}
    {if $OPTIONS.cart_billing == 'yes'}{include file="jojo_cart_checkout_billing.tpl"}{/if}
    {if $OPTIONS.cart_billing_first=='yes'}{include file="jojo_cart_checkout_shipping.tpl"}{/if}

    {if !$fields.userid && !($OPTIONS.cart_create_account =='no')}
    <fieldset id="register">
        <legend>Save your details</legend>
         <div class="checkbox">
                <label for="create_account"><input type="checkbox" name="create_account" id="create_account" value="1"{if $smarty.post.create_account == 1} checked="checked"{/if} /> Create a user account to speed up ordering next time?</label>
        </div>
        <div class="form-fieldset form-group">
            <label for="username">User name<span class="required">*</span></label>
            <input type="text" class="form-control input text required" size="10" name="username" id="username" value="{if $fields.username}{$fields.username}{/if}" />
        </div>
         <div class="form-fieldset form-group">
           <label for="password">Password<span class="required">*</span></label>
            <input type="password" class="form-control input text required" size="10" name="password" id="password" value="{if $fields.password}{$fields.password}{/if}" />
        </div>
         <div class="form-fieldset form-group">
            <label for="password_confirm">Confirm Password<span class="required">*</span></label>
            <input type="password" class="form-control input text required" size="10" name="confirm_password" id="password" value="{if $fields.password}{$fields.password}{/if}" />
        </div>
         <div class="form-fieldset form-group">
             <div class="checkbox  form-group">
                <label for="remember_password"><input type="checkbox" name="remember_password" id="remember_password" value="1" {if $smarty.post.remember_password == 1} checked="checked"{/if} />Remember password (on this computer)</label>
            <div>
        </div>
    </fieldset>
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
    {/if}
    <br>
    <div class="form-group">
        <label for="continue" class="control-label">&nbsp;</label>
        <input type="submit" class="btn btn-primary" name="continue" value="Continue"/>
    </div>
</form>
</div>
{/if}