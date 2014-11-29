----------------------------------------------------------------------------------
-- Company: Universite Bordeaux 1 departement EEA
-- Engineer: Autogenerated code 
--
-- Create Date:    
-- Design Name:
-- Module Name:    band_pass - Behavioral
-- Project Name:
-- Target Devices:
-- Tool versions:
-- Description:
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;-- use signed numbers for numerical computations
entity band_pass is
Port ( ent       : in   STD_LOGIC_VECTOR (15 downto 0); --N=16 bits
       sor       : out  STD_LOGIC_VECTOR (15 downto 0); --N=16 bits
       clk_50MHz : in std_logic ;
       f_ech     : in std_logic);
end band_pass;
architecture Behavioral of RII_exemple is
 signal tmp_1, tmp_3, x2_2, x1_2, opx2_2, x2_3, x1_3, opx2_3, x2_4, x1_4 : signed (15 downto 0) := "0000000000000000";-- signaux intermediaires sur 16 bits,  niveau 0
 signal opx2_4, x2_5, x1_5, opx2_5, x2_6, x1_6, opx2_6, x2_7, x1_7, opx2_7 : signed (15 downto 0) := "0000000000000000";-- signaux intermediaires sur 16 bits,  niveau 0
 signal output_16 : signed (15 downto 0) := "0000000000000000";-- signaux intermediaires sur 16 bits,  niveau 0
 signal opi1_2, tmp_17, tmp_18, tmp_19, tmp_20, i1_2, opi2_2, tmp_24, tmp_25, tmp_26 : signed (19 downto 0) := "00000000000000000000";-- signaux intermediaires sur 20 bits,  niveau 0
 signal tmp_27, i2_2, opi1_4, tmp_65, tmp_66, tmp_67, tmp_68, i1_4, opi2_4, tmp_72 : signed (19 downto 0) := "00000000000000000000";-- signaux intermediaires sur 20 bits,  niveau 0
 signal tmp_73, tmp_74, tmp_75, i2_4, opi1_6, tmp_113, tmp_114, tmp_115, tmp_116, i1_6 : signed (19 downto 0) := "00000000000000000000";-- signaux intermediaires sur 20 bits,  niveau 0
 signal opi2_6, tmp_120, tmp_121, tmp_122, tmp_123, i2_6 : signed (19 downto 0) := "00000000000000000000";-- signaux intermediaires sur 20 bits,  niveau 0
 signal opi1_3, tmp_41, tmp_42, tmp_43, tmp_44, i1_3, opi2_3, tmp_48, tmp_49, tmp_50 : signed (20 downto 0) := "000000000000000000000";-- signaux intermediaires sur 21 bits,  niveau 0
 signal tmp_51, i2_3, opi1_5, tmp_89, tmp_90, tmp_91, tmp_92, i1_5, opi2_5, tmp_96 : signed (20 downto 0) := "000000000000000000000";-- signaux intermediaires sur 21 bits,  niveau 0
 signal tmp_97, tmp_98, tmp_99, i2_5, opi1_7, tmp_137, tmp_138, tmp_139, tmp_140, i1_7 : signed (20 downto 0) := "000000000000000000000";-- signaux intermediaires sur 21 bits,  niveau 0
 signal opi2_7, tmp_144, tmp_145, tmp_146, tmp_147, i2_7 : signed (20 downto 0) := "000000000000000000000";-- signaux intermediaires sur 21 bits,  niveau 0
 signal tmp_2, tmp_4, tmp_5, tmp_6, tmp_7, tmp_8, tmp_9, tmp_10, tmp_11, tmp_12 : signed (31 downto 0) := "00000000000000000000000000000000";-- signaux intermediaires sur 32 bits,  niveau 0
 signal tmp_13, tmp_29, tmp_30, tmp_31, tmp_32, tmp_33, tmp_34, tmp_35, tmp_36, tmp_37 : signed (31 downto 0) := "00000000000000000000000000000000";-- signaux intermediaires sur 32 bits,  niveau 0
 signal tmp_53, tmp_54, tmp_55, tmp_56, tmp_57, tmp_58, tmp_59, tmp_60, tmp_61, tmp_77 : signed (31 downto 0) := "00000000000000000000000000000000";-- signaux intermediaires sur 32 bits,  niveau 0
 signal tmp_78, tmp_79, tmp_80, tmp_81, tmp_82, tmp_83, tmp_84, tmp_85, tmp_101, tmp_102 : signed (31 downto 0) := "00000000000000000000000000000000";-- signaux intermediaires sur 32 bits,  niveau 0
 signal tmp_103, tmp_104, tmp_105, tmp_106, tmp_107, tmp_108, tmp_109, tmp_125, tmp_126, tmp_127 : signed (31 downto 0) := "00000000000000000000000000000000";-- signaux intermediaires sur 32 bits,  niveau 0
 signal tmp_128, tmp_129, tmp_130, tmp_131, tmp_132, tmp_133, tmp_149, tmp_150, tmp_151, tmp_152 : signed (31 downto 0) := "00000000000000000000000000000000";-- signaux intermediaires sur 32 bits,  niveau 0
 signal tmp_153, tmp_154, tmp_155, tmp_156, tmp_157, tmp_158, tmp_159, tmp_160 : signed (31 downto 0) := "00000000000000000000000000000000";-- signaux intermediaires sur 32 bits,  niveau 0
begin
    ---------------------------------------------------------------------------------------------------------------
    -- begin of filter : convert 16 bits logic input :ent, to signed equivalent :tmp_1
    ---------------------------------------------------------------------------------------------------------------------
    tmp_1 <= signed(ent);
    tmp_2<= resize( tmp_1 , 32 );
    ---------------------------------------------
    -- code of cel 1
    ---------------------------------------------
     -- en<-en .2^0 
    tmp_3<= resize( tmp_2 , 16 ); -- en<-b0 . en 
    tmp_4 <= tmp_3 * to_signed(26342,16) ;
    tmp_149 <= shift_right(tmp_4,33) ; -- scale output of cel 1
    -- local output :tmp_149 of cel 1 will be accumulated
    ---------------------------------------------
    -- code of cel 2
    ---------------------------------------------
    tmp_5 <= shift_left(tmp_2,8) ; -- en<<L+LA ,L=-5,LA=13
      -- AR part of cel 2
    tmp_6 <= x2_2 * to_signed(14058,16) ; -- - a1 . x1 
    tmp_7 <= tmp_6 + tmp_5 ;
    tmp_8 <= opx2_2 * to_signed(-18837,16) ; -- - a2 . x2 
    tmp_9 <= tmp_8 + tmp_7 ;
    tmp_10 <= shift_right(tmp_9,13) ; -- vn<-en >> LA 
    x1_2 <= tmp_10(15 downto 0); -- x1=vn  
      -- MA part of cel 2
    tmp_11 <= x2_2 * to_signed(17326,16) ; -- en<-b1 . x2 ,because b0=0
    tmp_12 <= opx2_2 * to_signed(-6125,16) ; -- b2 .op x2
    tmp_13 <= tmp_12 + tmp_11 ; -- output of cel 2
    -- x2_2 <- q(x1_2), avec q=(2^-3)/(z-[ 1 - (2^-3) ] )
    z_1: process(clk_50MHz, f_ech)
    begin
      if rising_edge(clk_50MHz) then if f_ech='1' then opi1_2 <= i1_2 ;
           end if;
      end if;
    end process;
    x2_2 <= tmp_17(15 downto 0);
    tmp_18<= resize( x1_2 , 20 );
    tmp_19<= resize( x2_2 , 20 );
    tmp_20 <= tmp_18 - tmp_19 ;
    i1_2 <= tmp_20 + opi1_2 ;
    tmp_17 <= shift_right(opi1_2,3) ;
    -- opx2_2 <- q(x2_2), avec q=(2^-3)/(z-[ 1 - (2^-3) ] )
    z_2: process(clk_50MHz, f_ech)
    begin
      if rising_edge(clk_50MHz) then if f_ech='1' then opi2_2 <= i2_2 ;
           end if;
      end if;
    end process;
    opx2_2 <= tmp_24(15 downto 0);
    tmp_25<= resize( x2_2 , 20 );
    tmp_26<= resize( opx2_2 , 20 );
    tmp_27 <= tmp_25 - tmp_26 ;
    i2_2 <= tmp_27 + opi2_2 ;
    tmp_24 <= shift_right(opi2_2,3) ;
    tmp_150 <= shift_right(tmp_13,1) ; -- scale output of cel 2
    -- accumulation of output: tmp_150 of cel 2 with local output: tmp_149
    tmp_151 <= tmp_149 + tmp_150 ;
    ---------------------------------------------
    -- code of cel 3
    ---------------------------------------------
    tmp_29 <= shift_left(tmp_2,8) ; -- en<<L+LA ,L=-6,LA=14
      -- AR part of cel 3
    tmp_30 <= x2_3 * to_signed(30623,16) ; -- - a1 . x1 
    tmp_31 <= tmp_30 + tmp_29 ;
    tmp_32 <= opx2_3 * to_signed(-30589,16) ; -- - a2 . x2 
    tmp_33 <= tmp_32 + tmp_31 ;
    tmp_34 <= shift_right(tmp_33,14) ; -- vn<-en >> LA 
    x1_3 <= tmp_34(15 downto 0); -- x1=vn  
      -- MA part of cel 3
    tmp_35 <= x2_3 * to_signed(11656,16) ; -- en<-b1 . x2 ,because b0=0
    tmp_36 <= opx2_3 * to_signed(-20138,16) ; -- b2 .op x2
    tmp_37 <= tmp_36 + tmp_35 ; -- output of cel 3
    -- x2_3 <- q(x1_3), avec q=(2^-4)/(z-[ 1 - (2^-4) ] )
    z_3: process(clk_50MHz, f_ech)
    begin
      if rising_edge(clk_50MHz) then if f_ech='1' then opi1_3 <= i1_3 ;
           end if;
      end if;
    end process;
    x2_3 <= tmp_41(15 downto 0);
    tmp_42<= resize( x1_3 , 21 );
    tmp_43<= resize( x2_3 , 21 );
    tmp_44 <= tmp_42 - tmp_43 ;
    i1_3 <= tmp_44 + opi1_3 ;
    tmp_41 <= shift_right(opi1_3,4) ;
    -- opx2_3 <- q(x2_3), avec q=(2^-4)/(z-[ 1 - (2^-4) ] )
    z_4: process(clk_50MHz, f_ech)
    begin
      if rising_edge(clk_50MHz) then if f_ech='1' then opi2_3 <= i2_3 ;
           end if;
      end if;
    end process;
    opx2_3 <= tmp_48(15 downto 0);
    tmp_49<= resize( x2_3 , 21 );
    tmp_50<= resize( opx2_3 , 21 );
    tmp_51 <= tmp_49 - tmp_50 ;
    i2_3 <= tmp_51 + opi2_3 ;
    tmp_48 <= shift_right(opi2_3,4) ;
     -- scale output of cel 3
    -- accumulation of output: tmp_37 of cel 3 with local output: tmp_151
    tmp_152 <= tmp_151 + tmp_37 ;
    ---------------------------------------------
    -- code of cel 4
    ---------------------------------------------
    tmp_53 <= shift_left(tmp_2,10) ; -- en<<L+LA ,L=-4,LA=14
      -- AR part of cel 4
    tmp_54 <= x2_4 * to_signed(26666,16) ; -- - a1 . x1 
    tmp_55 <= tmp_54 + tmp_53 ;
    tmp_56 <= opx2_4 * to_signed(-30649,16) ; -- - a2 . x2 
    tmp_57 <= tmp_56 + tmp_55 ;
    tmp_58 <= shift_right(tmp_57,14) ; -- vn<-en >> LA 
    x1_4 <= tmp_58(15 downto 0); -- x1=vn  
      -- MA part of cel 4
    tmp_59 <= x2_4 * to_signed(-18446,16) ; -- en<-b1 . x2 ,because b0=0
    tmp_60 <= opx2_4 * to_signed(-2888,16) ; -- b2 .op x2
    tmp_61 <= tmp_60 + tmp_59 ; -- output of cel 4
    -- x2_4 <- q(x1_4), avec q=(2^-3)/(z-[ 1 - (2^-3) ] )
    z_5: process(clk_50MHz, f_ech)
    begin
      if rising_edge(clk_50MHz) then if f_ech='1' then opi1_4 <= i1_4 ;
           end if;
      end if;
    end process;
    x2_4 <= tmp_65(15 downto 0);
    tmp_66<= resize( x1_4 , 20 );
    tmp_67<= resize( x2_4 , 20 );
    tmp_68 <= tmp_66 - tmp_67 ;
    i1_4 <= tmp_68 + opi1_4 ;
    tmp_65 <= shift_right(opi1_4,3) ;
    -- opx2_4 <- q(x2_4), avec q=(2^-3)/(z-[ 1 - (2^-3) ] )
    z_6: process(clk_50MHz, f_ech)
    begin
      if rising_edge(clk_50MHz) then if f_ech='1' then opi2_4 <= i2_4 ;
           end if;
      end if;
    end process;
    opx2_4 <= tmp_72(15 downto 0);
    tmp_73<= resize( x2_4 , 20 );
    tmp_74<= resize( opx2_4 , 20 );
    tmp_75 <= tmp_73 - tmp_74 ;
    i2_4 <= tmp_75 + opi2_4 ;
    tmp_72 <= shift_right(opi2_4,3) ;
    tmp_153 <= shift_right(tmp_61,1) ; -- scale output of cel 4
    -- accumulation of output: tmp_153 of cel 4 with local output: tmp_152
    tmp_154 <= tmp_152 + tmp_153 ;
    ---------------------------------------------
    -- code of cel 5
    ---------------------------------------------
    tmp_77 <= shift_left(tmp_2,10) ; -- en<<L+LA ,L=-4,LA=14
      -- AR part of cel 5
    tmp_78 <= x2_5 * to_signed(27888,16) ; -- - a1 . x1 
    tmp_79 <= tmp_78 + tmp_77 ;
    tmp_80 <= opx2_5 * to_signed(-32083,16) ; -- - a2 . x2 
    tmp_81 <= tmp_80 + tmp_79 ;
    tmp_82 <= shift_right(tmp_81,14) ; -- vn<-en >> LA 
    x1_5 <= tmp_82(15 downto 0); -- x1=vn  
      -- MA part of cel 5
    tmp_83 <= x2_5 * to_signed(-5320,16) ; -- en<-b1 . x2 ,because b0=0
    tmp_84 <= opx2_5 * to_signed(17008,16) ; -- b2 .op x2
    tmp_85 <= tmp_84 + tmp_83 ; -- output of cel 5
    -- x2_5 <- q(x1_5), avec q=(2^-4)/(z-[ 1 - (2^-4) ] )
    z_7: process(clk_50MHz, f_ech)
    begin
      if rising_edge(clk_50MHz) then if f_ech='1' then opi1_5 <= i1_5 ;
           end if;
      end if;
    end process;
    x2_5 <= tmp_89(15 downto 0);
    tmp_90<= resize( x1_5 , 21 );
    tmp_91<= resize( x2_5 , 21 );
    tmp_92 <= tmp_90 - tmp_91 ;
    i1_5 <= tmp_92 + opi1_5 ;
    tmp_89 <= shift_right(opi1_5,4) ;
    -- opx2_5 <- q(x2_5), avec q=(2^-4)/(z-[ 1 - (2^-4) ] )
    z_8: process(clk_50MHz, f_ech)
    begin
      if rising_edge(clk_50MHz) then if f_ech='1' then opi2_5 <= i2_5 ;
           end if;
      end if;
    end process;
    opx2_5 <= tmp_96(15 downto 0);
    tmp_97<= resize( x2_5 , 21 );
    tmp_98<= resize( opx2_5 , 21 );
    tmp_99 <= tmp_97 - tmp_98 ;
    i2_5 <= tmp_99 + opi2_5 ;
    tmp_96 <= shift_right(opi2_5,4) ;
     -- scale output of cel 5
    -- accumulation of output: tmp_85 of cel 5 with local output: tmp_154
    tmp_155 <= tmp_154 + tmp_85 ;
    ---------------------------------------------
    -- code of cel 6
    ---------------------------------------------
    tmp_101 <= shift_left(tmp_2,10) ; -- en<<L+LA ,L=-4,LA=14
      -- AR part of cel 6
    tmp_102 <= x2_6 * to_signed(27007,16) ; -- - a1 . x1 
    tmp_103 <= tmp_102 + tmp_101 ;
    tmp_104 <= opx2_6 * to_signed(-23817,16) ; -- - a2 . x2 
    tmp_105 <= tmp_104 + tmp_103 ;
    tmp_106 <= shift_right(tmp_105,14) ; -- vn<-en >> LA 
    x1_6 <= tmp_106(15 downto 0); -- x1=vn  
      -- MA part of cel 6
    tmp_107 <= x2_6 * to_signed(26136,16) ; -- en<-b1 . x2 ,because b0=0
    tmp_108 <= opx2_6 * to_signed(26924,16) ; -- b2 .op x2
    tmp_109 <= tmp_108 + tmp_107 ; -- output of cel 6
    -- x2_6 <- q(x1_6), avec q=(2^-3)/(z-[ 1 - (2^-3) ] )
    z_9: process(clk_50MHz, f_ech)
    begin
      if rising_edge(clk_50MHz) then if f_ech='1' then opi1_6 <= i1_6 ;
           end if;
      end if;
    end process;
    x2_6 <= tmp_113(15 downto 0);
    tmp_114<= resize( x1_6 , 20 );
    tmp_115<= resize( x2_6 , 20 );
    tmp_116 <= tmp_114 - tmp_115 ;
    i1_6 <= tmp_116 + opi1_6 ;
    tmp_113 <= shift_right(opi1_6,3) ;
    -- opx2_6 <- q(x2_6), avec q=(2^-3)/(z-[ 1 - (2^-3) ] )
    z_10: process(clk_50MHz, f_ech)
    begin
      if rising_edge(clk_50MHz) then if f_ech='1' then opi2_6 <= i2_6 ;
           end if;
      end if;
    end process;
    opx2_6 <= tmp_120(15 downto 0);
    tmp_121<= resize( x2_6 , 20 );
    tmp_122<= resize( opx2_6 , 20 );
    tmp_123 <= tmp_121 - tmp_122 ;
    i2_6 <= tmp_123 + opi2_6 ;
    tmp_120 <= shift_right(opi2_6,3) ;
    tmp_156 <= shift_right(tmp_109,2) ; -- scale output of cel 6
    -- accumulation of output: tmp_156 of cel 6 with local output: tmp_155
    tmp_157 <= tmp_155 + tmp_156 ;
    ---------------------------------------------
    -- code of cel 7
    ---------------------------------------------
    tmp_125 <= shift_left(tmp_2,10) ; -- en<<L+LA ,L=-3,LA=13
      -- AR part of cel 7
    tmp_126 <= x2_7 * to_signed(12210,16) ; -- - a1 . x1 
    tmp_127 <= tmp_126 + tmp_125 ;
    tmp_128 <= opx2_7 * to_signed(-19800,16) ; -- - a2 . x2 
    tmp_129 <= tmp_128 + tmp_127 ;
    tmp_130 <= shift_right(tmp_129,13) ; -- vn<-en >> LA 
    x1_7 <= tmp_130(15 downto 0); -- x1=vn  
      -- MA part of cel 7
    tmp_131 <= x2_7 * to_signed(-879,16) ; -- en<-b1 . x2 ,because b0=0
    tmp_132 <= opx2_7 * to_signed(-31563,16) ; -- b2 .op x2
    tmp_133 <= tmp_132 + tmp_131 ; -- output of cel 7
    -- x2_7 <- q(x1_7), avec q=(2^-4)/(z-[ 1 - (2^-4) ] )
    z_11: process(clk_50MHz, f_ech)
    begin
      if rising_edge(clk_50MHz) then if f_ech='1' then opi1_7 <= i1_7 ;
           end if;
      end if;
    end process;
    x2_7 <= tmp_137(15 downto 0);
    tmp_138<= resize( x1_7 , 21 );
    tmp_139<= resize( x2_7 , 21 );
    tmp_140 <= tmp_138 - tmp_139 ;
    i1_7 <= tmp_140 + opi1_7 ;
    tmp_137 <= shift_right(opi1_7,4) ;
    -- opx2_7 <- q(x2_7), avec q=(2^-4)/(z-[ 1 - (2^-4) ] )
    z_12: process(clk_50MHz, f_ech)
    begin
      if rising_edge(clk_50MHz) then if f_ech='1' then opi2_7 <= i2_7 ;
           end if;
      end if;
    end process;
    opx2_7 <= tmp_144(15 downto 0);
    tmp_145<= resize( x2_7 , 21 );
    tmp_146<= resize( opx2_7 , 21 );
    tmp_147 <= tmp_145 - tmp_146 ;
    i2_7 <= tmp_147 + opi2_7 ;
    tmp_144 <= shift_right(opi2_7,4) ;
    tmp_158 <= shift_right(tmp_133,1) ; -- scale output of cel 7
    -- accumulation of output: tmp_158 of cel 7 with local output: tmp_157
    tmp_159 <= tmp_157 + tmp_158 ;
    ----------------------------------------------------------
    -- end of filter, scale global output : tmp_159
    ----------------------------------------------------------
    tmp_160 <= shift_right(tmp_159,12) ;
    output_16 <= tmp_160(15 downto 0);
    sor <= std_logic_vector(output_16);
end Behavioral;