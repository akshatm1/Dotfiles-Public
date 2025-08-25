const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0b0c1b", /* black   */
  [1] = "#08368B", /* red     */
  [2] = "#102F99", /* green   */
  [3] = "#1255A5", /* yellow  */
  [4] = "#4B4999", /* blue    */
  [5] = "#106ED0", /* magenta */
  [6] = "#1697E1", /* cyan    */
  [7] = "#c2c2c6", /* white   */

  /* 8 bright colors */
  [8]  = "#5a5c6f",  /* black   */
  [9]  = "#08368B",  /* red     */
  [10] = "#102F99", /* green   */
  [11] = "#1255A5", /* yellow  */
  [12] = "#4B4999", /* blue    */
  [13] = "#106ED0", /* magenta */
  [14] = "#1697E1", /* cyan    */
  [15] = "#c2c2c6", /* white   */

  /* special colors */
  [256] = "#0b0c1b", /* background */
  [257] = "#c2c2c6", /* foreground */
  [258] = "#c2c2c6",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
