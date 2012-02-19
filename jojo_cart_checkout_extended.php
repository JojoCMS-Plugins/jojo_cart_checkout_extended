<?php
/**
 *                    Jojo CMS
 *                ================
 *
 * Copyright 2008 Harvey Kane <code@ragepank.com>
 * Copyright 2008 JojoCMS
 *
 * See the enclosed file license.txt for license information (LGPL). If you
 * did not receive this file, see http://www.fsf.org/copyleft/lgpl.html.
 *
 * @author  Harvey Kane <code@ragepank.com>
 * @author  Mike Cochrane <mikec@mikenz.geek.nz>
 * @license http://www.fsf.org/copyleft/lgpl.html GNU Lesser General Public License
 * @link    http://www.jojocms.org JojoCMS
 */

class jojo_plugin_jojo_cart_checkout_extended extends JOJO_Plugin
{

    function _getContent()
    {
        global $smarty, $_USERID;

        /* Get the cart array */
        $cart = call_user_func(array(Jojo_Cart_Class, 'getCart'));
        $testmode = call_user_func(array(Jojo_Cart_Class, 'isTestMode'));
        $smarty->assign('token', $cart->token);

        /* Build list of countries for UI */
        $countries = array();
        $countries[] = array('code' => '', 'name' => 'Select country');
        $countries = array_merge($countries, Jojo::selectQuery("SELECT cc.countrycode as code, cc.name, 1 as special FROM {cart_country} as cc WHERE special = 'yes' ORDER BY name"));
        if (count($countries) > 1) {
            $countries[] = array('code' => '', 'name' => '----------');
        }
        $countries = array_merge($countries, Jojo::selectQuery("SELECT cc.countrycode as code, cc.name, 0 as special FROM {cart_country} as cc ORDER BY name"));
        $smarty->assign('countries', $countries);

        /* Pre populate some fields when in test mode */
        if ($testmode && !count($cart->fields) < 6) {
            $cart->fields['billing_firstname']  = 'admin';
            $cart->fields['billing_lastname']   = 'admin';
            $cart->fields['billing_company']    = '';
            $cart->fields['billing_email']      = _WEBMASTERADDRESS;
            $cart->fields['billing_phone']      = '555-5555';
            $cart->fields['billing_address1']   = '123 Test Road';
            $cart->fields['billing_address2']   = '';
            $cart->fields['billing_suburb']     = 'Test';
            $cart->fields['billing_city']       = 'Testville';
            $cart->fields['billing_postcode']   = '1234';
            $cart->fields['billing_country']    = 'NZ';

            $cart->fields['shipping_firstname'] = 'Test';
            $cart->fields['shipping_lastname']  = 'Test';
            $cart->fields['shipping_company']    = '';
            $cart->fields['shipping_phone']     = '555-5555';
            $cart->fields['shipping_address1']  = '123 Test Road';
            $cart->fields['shipping_address2']  = '';
            $cart->fields['shipping_suburb']    = 'Test';
            $cart->fields['shipping_city']      = 'Testville';
            $cart->fields['shipping_postcode']  = '1234';
            $cart->fields['shipping_country']   = 'NZ';
            $cart->fields['shipping_special']   = '';
        }

        /* Pre populate a logged in user's details */
        if (!empty($_USERID) && !count($cart->fields)) {
            $user = Jojo::selectRow("SELECT userid, us_firstname, us_lastname, us_email FROM {user} WHERE userid = ? LIMIT 1", array($_USERID));
            if (isset($user['userid'])) {
                $cart->fields['userid']             = $user['userid'];
                $cart->fields['billing_firstname']  = $user['us_firstname'];
                $cart->fields['billing_lastname']   = $user['us_lastname'];
                $cart->fields['shipping_firstname'] = $user['us_firstname'];
                $cart->fields['shipping_lastname']  = $user['us_lastname'];
                $cart->fields['billing_email']      = $user['us_email'];
                $cart->fields['shipping_email']     = $user['us_email'];
            }
        }

        /* filter to allow modification of fields data - such as auto-population of certain fields */
        $cart->fields = Jojo::applyFilter('jojo_cart_checkout:populate_fields', $cart->fields);

        /* Continue button not pressed */
        if (!Jojo::getFormData('continue')) {
            $content = array();
            $smarty->assign('fields', $cart->fields);
            $content['title']      = 'Shipping and Billing Information';
            $content['seotitle']   = 'Shipping and Billing Information';
            $content['content']    = $smarty->fetch('jojo_cart_checkout_extended.tpl');
            return $content;
        }

        /* Get form values */
        $fields = array('billing_firstname', 'billing_lastname', 'billing_company',
            'billing_email', 'billing_phone', 'billing_address1', 'billing_address2',
            'billing_suburb', 'billing_city', 'billing_state',
            'billing_postcode', 'billing_country', 'shipping_firstname', 'shipping_company',
            'shipping_lastname', 'shipping_email', 'shipping_phone', 'shipping_address1',
            'shipping_address2', 'shipping_suburb', 'shipping_city',
            'shipping_state', 'shipping_postcode', 'shipping_country', 'shipping_special');
        $fields = Jojo::applyFilter('jojo_cart_checkout:get_fields', $fields);
        foreach($fields as $name) {
            $cart->fields[$name] = Jojo::getFormData($name, false);
        }

        call_user_func(array(Jojo_Cart_Class, 'saveCart'));

        /* Check for required fields */
        $requiredFields = array(
            'shipping_firstname' => 'Please enter your first name.',
            'shipping_lastname'  => 'Please enter your last name.',
            'shipping_address1'  => 'Please enter your shipping address.',
            'shipping_city'      => 'Please enter your shipping city.',
            'shipping_postcode'  => 'Please enter your post code.',
            'shipping_country'   => 'Please select your country.',
        );

        if (Jojo::getOption('cart_billing', 'yes') == 'yes') {
          $requiredFields = $requiredFields + array(
              'billing_firstname'  => 'Please enter your first name.',
              'billing_lastname'   => 'Please enter your last name.',
              'billing_email'      => 'Please enter your email address.',
              'billing_address1'   => 'Please enter your billing address.',
              'billing_city'       => 'Please enter your billing city.',
              'billing_postcode'   => 'Please enter your post code.',
              'billing_country'    => 'Please select your country.',
          );
        }

        if (Jojo::getOption('cart_phone_required', 'no') == 'yes') {
            $requiredFields['shipping_phone'] = 'Please enter your shipping phone number.';
            if (Jojo::getOption('cart_billing', 'yes') == 'yes')  $requiredFields['billing_phone'] = 'Please enter your billing phone number.';
        }
        $requiredFields = Jojo::applyFilter('jojo_cart_checkout:required_fields', $requiredFields);
        $errors = array();
        foreach($requiredFields as $name => $errorMsg) {
            if (!$cart->fields[$name]) {
                $errors[$name] = $errorMsg;
            }
        }
        if (!empty($cart->fields['Email']) && !Jojo::checkEmailFormat($cart->fields['Email'])) {
            $errors[] = 'Please enter a valid email address.';
        }

        $name= $cart->fields['shipping_firstname'].' '.$cart->fields['shipping_lastname'];
        if(strlen($name)>35) $errors[] = 'Please a firstname/lastname combination with max 35 characters please';

        if (Jojo::getOption('cart_billing', 'yes') == 'yes') {
            $name= $cart->fields['billing_firstname'].' '.$cart->fields['billing_lastname'];
            if(strlen($name)>35) $errors[] = 'Please a firstname/lastname combination with max 35 characters please';
        }
        $smarty->assign('required_fields', $requiredFields);

        if (count($errors)) {
            /* There were errors, let the user fix them */
            $smarty->assign('errors', $errors);
            $content = array();
            $smarty->assign('fields', $cart->fields);
            $content['title']      = 'Shipping and Billing Information';
            $content['seotitle']   = 'Shipping and Billing Information';
            $content['content']    = $smarty->fetch('jojo_cart_checkout_extended.tpl');
            return $content;
        }

        /* Set the shipping region in the cart */
        $shippingRegion = self::locationToRegion($cart->fields['shipping_country'],
                                                 $cart->fields['shipping_state'],
                                                 $cart->fields['shipping_city']);
        call_user_func(array(Jojo_Cart_Class, 'setShippingRegion'), $shippingRegion);

        Jojo::redirect(_SECUREURL . '/cart/shipping/');
    }

    /**
     * Convert the user shipping details to a freight region
     */
    private static function locationToRegion($country, $state, $city)
    {
        /* Try match city, state, country */
        $res = Jojo::selectRow('SELECT * FROM {cart_city} WHERE countrycode = ? AND statecode = ? and city = ?', array($country, $state, $city));
        if ($res && $res['region']) {
            return $res['region'];
        }

        /* Try match state and country */
        $res = Jojo::selectRow('SELECT * FROM {cart_state} WHERE countrycode = ? AND statecode = ?', array($country, $state));
        if ($res && $res['region']) {
            return $res['region'];
        }

        /* Try match country */
        $res = Jojo::selectRow('SELECT * FROM {cart_country} WHERE countrycode = ?', array($country));
        if ($res && $res['region']) {
            return $res['region'];
        }

        return '';
    }

    function getCorrectUrl()
    {
        return _SECUREURL.'/cart/checkout/';
    }

    /**
     * Return the region that this order will be shipped to
     */
    public static function shippingRegion() {

    }
}
