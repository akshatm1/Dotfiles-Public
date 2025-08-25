/* Taken from https://github.com/djpohly/dwl/issues/466 */
#define COLOR(hex)    { ((hex >> 24) & 0xFF) / 255.0f, \
                        ((hex >> 16) & 0xFF) / 255.0f, \
                        ((hex >> 8) & 0xFF) / 255.0f, \
                        (hex & 0xFF) / 255.0f }

static const float rootcolor[]             = COLOR(0x0b0c1bff);
static uint32_t colors[][3]                = {
	/*               fg          bg          border    */
	[SchemeNorm] = { 0xc2c2c6ff, 0x0b0c1bff, 0x5a5c6fff },
	[SchemeSel]  = { 0xc2c2c6ff, 0x102F99ff, 0x08368Bff },
	[SchemeUrg]  = { 0xc2c2c6ff, 0x08368Bff, 0x102F99ff },
};
