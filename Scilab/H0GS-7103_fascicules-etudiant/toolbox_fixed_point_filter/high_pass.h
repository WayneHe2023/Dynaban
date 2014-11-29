/*
* File:   band_stop.h
* Author: autogenerated
*
* Created on 
*/

#ifndef _HIGH_PASS_H
  #define _HIGH_PASS_H
  #define int_16_high_pass short int
  #define int_32_high_pass long int
  typedef struct {
      int nb_coeffs;
      int nb_states;
      int_16_high_pass *coeffs;
      int_32_high_pass *states;
  } s_16bits_filter_high_pass;
  typedef s_16bits_filter_high_pass *p_16bits_filter_high_pass;
  /* creator of structure p_16bits_filter_high_pass */
  extern p_16bits_filter_high_pass new_16bits_filter_high_pass(void);
  extern void destroy_16bits_filter_high_pass(p_16bits_filter_high_pass p_high_pass);
  extern int_32_high_pass one_step_16bits_filter_high_pass(int_16_high_pass en_16, p_16bits_filter_high_pass p_high_pass);
  typedef struct {
      int nb_cels;
      int nb_coeffs;
      int nb_states;
      double *coeffs;
      double *states;
  } s_real_filter_high_pass;
  typedef s_real_filter_high_pass *p_real_filter_high_pass;
  extern double one_step_real_filter_high_pass(double en, p_real_filter_high_pass f);
  extern void destroy_real_filter_high_pass(p_real_filter_high_pass f);
  extern p_real_filter_high_pass new_real_filter_high_pass(void);
#endif /* _HIGH_PASS_H */