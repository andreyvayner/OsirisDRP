;                . 0 0 0 = bad pixel
;                . 0 0 1 = good pixel, not interpolated
;                . 1 1 1 = good pixel interpolated, good interpolated
;                . 0 1 1 = good pixel interpolated, not good interpolated
;
; STATUS : untested
;
; HISTORY : 8.8.2004, created
;
; AUTHOR : Christof Iserlohe (iserlohe@ph1.uni-koeln.de)
;
;-----------------------------------------------------------------------------

function qbit_translate, mb_Q, rev=rev

   n_Pix = size(mb_Q, /N_ELEMENTS)

   if ( NOT keyword_set(rev) ) then begin

      for i=0, n_Pix-1 do begin

         b_Bit0 = extbit (mb_Q(i),0)  ; Quality bit
         b_Bit1 = extbit (mb_Q(i),1)  ; Interpolation bit
         b_Bit2 = extbit (mb_Q(i),2)  ; Interpolation quality bit

         mb_Q(i) = setbit (mb_Q(i),0,0)
         mb_Q(i) = setbit (mb_Q(i),1,0)
         mb_Q(i) = setbit (mb_Q(i),2,0)

         ; the pixel is bad
         if ( b_Bit0 eq 0 ) then begin
            mb_Q(i) = setbit (mb_Q(i),0,0)
            mb_Q(i) = setbit (mb_Q(i),1,0)
         end

         ; the pixel is good and not interpolated
         if ( b_Bit0 eq 1 and b_Bit1 eq 0 ) then begin
            mb_Q(i) = setbit (mb_Q(i),0,1)
            mb_Q(i) = setbit (mb_Q(i),1,1)
         end

         ; the pixel is good and good interpolated
         if ( b_Bit0 eq 1 and b_Bit1 eq 1 and b_Bit2 eq 1 ) then begin
            mb_Q(i) = setbit (mb_Q(i),0,0)
            mb_Q(i) = setbit (mb_Q(i),1,1)
         end

         ; the pixel is good but badly interpolated
         if ( b_Bit0 eq 1 and b_Bit1 eq 1 and b_Bit2 eq 0 ) then begin
            mb_Q(i) = setbit (mb_Q(i),0,1)
            mb_Q(i) = setbit (mb_Q(i),1,0)
         end

      end

  endif else begin

      for i=0, n_Pix-1 do begin

         b_Bit0 = extbit (mb_Q(i),0)
         b_Bit1 = extbit (mb_Q(i),1)

         mb_Q(i) = setbit (mb_Q(i),0,0)
         mb_Q(i) = setbit (mb_Q(i),1,0)
         mb_Q(i) = setbit (mb_Q(i),2,0)

         ; the pixel is bad
         if ( b_Bit0 eq 0 and b_Bit1 eq 0 ) then begin
            mb_Q(i) = setbit (mb_Q(i),0,0)
         end

         ; the pixel is good and not interpolated
         if ( b_Bit0 eq 1 and b_Bit1 eq 1 ) then begin
            mb_Q(i) = setbit (mb_Q(i),0,1)
            mb_Q(i) = setbit (mb_Q(i),1,0)
         end

         ; the pixel is good and good interpolated
         if ( b_Bit0 eq 0 and b_Bit1 eq 1 ) then begin
            mb_Q(i) = setbit (mb_Q(i),0,1)
            mb_Q(i) = setbit (mb_Q(i),1,1)
            mb_Q(i) = setbit (mb_Q(i),2,1)
         end

         ; the pixel is good but badly interpolated
         if ( b_Bit0 eq 1 and b_Bit1 eq 0 ) then begin
            mb_Q(i) = setbit (mb_Q(i),0,1)
            mb_Q(i) = setbit (mb_Q(i),1,1)
            mb_Q(i) = setbit (mb_Q(i),2,0)
         end

      end

  end

  return, mb_Q

end
