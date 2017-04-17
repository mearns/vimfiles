/**
 * File: `!p
snip.rv = snip.fn
`
 *
 */
#ifndef ${1:`!p
import re

snip.rv = re.sub(r'([a-z])([A-Z])', r'\1_\2', snip.fn).upper().replace(' ', '_').replace('.', '_')
`}
#define $1

$0

#endif
//end inclusion filter

