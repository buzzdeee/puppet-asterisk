# == Defined Type: asterisk::config::mailbox
#  This defined type can be used to add mailboxes to INI file constructed
#  with puppetlabs/concat module.
#
# === Requirements
#  Module: puppetlabs/concat
#
# === Parameters
#  [*target*]
#    *REQUIRED* Target file that the user credentials should be stored
#    to.
#
#  [*user*]
#    *REQUIRED* Username for credentials. No default.
#
#  [*secret*]
#    Secret to log in with. Default to empty string ("").
#
#  [*read*]
#    String VALUE
#    Default: undef
#
#    If defined, place the string VALUE as a keypair "read = VALUE"
#    for the user.
#
#  [*write*]
#    String VALUE
#    Default: undef
#
#    If defined, place the string VALUE as a keypair "write = VALUE"
#    for the user.
#
#  [*permit*]
#    Array of Strings
#    Default: undef
#
#    If defined, place the multiple lines of keypairs "permit = VALUE"
#    for the user.
#
#  [*deny*]
#    Array of Strings
#    Default: undef
#
#    If defined, place the multiple lines of keypairs "deny = VALUE"
#    for the user.
#
#  [*eventfilter*]
#    Array of Strings
#    Default: undef
#
#    If defined, place the multiple lines of keypairs "eventfilter = VALUE"
#    for the user.
#
# === Example
# Add a user 'asterisk' with the secret 'asterisk' for AMI service
# configuration.
#
#     class { '::asterisk':
#         manage_config   => true,
#         manager_enabled => 'yes',
#     }
#     # Add voicemail boxes to the [default] context
# <mailbox>=<password>,<name>,<email>,<pager_email>,<options>
#     asterisk::config::mailbox { 'default':
#         mailboxes => { 
#              '1234' => {
#                password    => '3456',
#                name        => 'Example User',
#                email       => 'ex@example.com',
#                pager_email => 'ample@example.com',
#                options     => 'o1=val1|o2=val2|o3=val3'
#              }
#              '6789' => {
#                password    => '2323',
#                name        => 'Example 2',
#                email       => 'adfsad@example.com',
#                pager_email => 'lssdfl@example.com',
#                options     => 'o1=val1|o2=val2|o3=val3'
#              }
#        }
#     }
#

define asterisk::config::mailbox (
  $context   = $title,
  $mailboxes = [],
) inherits asterisk::params {

  validate_string($context)
  validate_array($mailboxes)

  concat::fragment{"vmcontext_${context}":
    target  => ${astetcdir}/voicemail.conf,
    content => template('asterisk/mailbox.erb'),
    order   => '20'
  }
}
