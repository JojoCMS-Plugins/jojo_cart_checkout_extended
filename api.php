<?php
$_options[] = array(
    'id'          => 'cart_create_account',
    'category'    => 'Cart',
    'label'       => 'Create user account',
    'description' => 'Gives the user the option to create an account to save contact details for their next transaction.',
    'type'        => 'radio',
    'default'     => 'yes',
    'options'     => 'yes,no',
    'plugin'      => 'jojo_cart_checkout_extended'
);

$_options[] = array(
    'id'          => 'cart_special',
    'category'    => 'Cart',
    'label'       => 'Include Special Instructions field',
    'description' => 'Adds a SPECIAL INSTRUCTIONS field onto the checkout page.',
    'type'        => 'radio',
    'default'     => 'no',
    'options'     => 'yes,no',
    'plugin'      => 'jojo_cart_checkout_extended'
);

$_options[] = array(
    'id'          => 'cart_phone_required',
    'category'    => 'Cart',
    'label'       => 'Phone number required field',
    'description' => 'The phone number is a required field in the checkout process',
    'type'        => 'radio',
    'default'     => 'no',
    'options'     => 'yes,no',
    'plugin'      => 'jojo_cart_checkout_extended'
);