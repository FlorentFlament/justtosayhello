; TIATracker music player
; Copyright 2016 Andre "Kylearan" Wichmann
; Website: https://bitbucket.org/kylearan/tiatracker
; Email: andre.wichmann@gmx.de
;
; Licensed under the Apache License, Version 2.0 (the "License");
; you may not use this file except in compliance with the License.
; You may obtain a copy of the License at
;
;   http://www.apache.org/licenses/LICENSE-2.0
;
; Unless required by applicable law or agreed to in writing, software
; distributed under the License is distributed on an "AS IS" BASIS,
; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
; See the License for the specific language governing permissions and
; limitations under the License.

; Song author: Glafouk
; Song name: SkarmaSea - v2

; @com.wudsn.ide.asm.hardware=ATARI2600

; =====================================================================
; TIATracker melodic and percussion instruments, patterns and sequencer
; data.
; =====================================================================
tt_TrackDataStart:

; =====================================================================
; Melodic instrument definitions (up to 7). tt_envelope_index_c0/1 hold
; the index values into these tables for the current instruments played
; in channel 0 and 1.
; 
; Each instrument is defined by:
; - tt_InsCtrlTable: the AUDC value
; - tt_InsADIndexes: the index of the start of the ADSR envelope as
;       defined in tt_InsFreqVolTable
; - tt_InsSustainIndexes: the index of the start of the Sustain phase
;       of the envelope
; - tt_InsReleaseIndexes: the index of the start of the Release phase
; - tt_InsFreqVolTable: The AUDF frequency and AUDV volume values of
;       the envelope
; =====================================================================

; Instrument master CTRL values
tt_InsCtrlTable:
        dc.b $08, $06, $04, $0c, $04, $0c, $0c


; Instrument Attack/Decay start indexes into ADSR tables.
tt_InsADIndexes:
        dc.b $00, $04, $0e, $0e, $1b, $1b, $22


; Instrument Sustain start indexes into ADSR tables
tt_InsSustainIndexes:
        dc.b $00, $0a, $17, $17, $1e, $1e, $2b


; Instrument Release start indexes into ADSR tables
; Caution: Values are stored with an implicit -1 modifier! To get the
; real index, add 1.
tt_InsReleaseIndexes:
        dc.b $01, $0b, $18, $18, $1f, $1f, $2c


; AUDVx and AUDFx ADSR envelope values.
; Each byte encodes the frequency and volume:
; - Bits 7..4: Freqency modifier for the current note ([-8..7]),
;       8 means no change. Bit 7 is the sign bit.
; - Bits 3..0: Volume
; Between sustain and release is one byte that is not used and
; can be any value.
; The end of the release phase is encoded by a 0.
tt_InsFreqVolTable:
; 0: vide
        dc.b $80, $00, $80, $00
; 1: bass2
        dc.b $8f, $8e, $8d, $8c, $8a, $87, $83, $00
        dc.b $80, $00
; 2+3: Lead
        dc.b $8b, $8b, $8a, $88, $82, $87, $87, $86
        dc.b $83, $81, $00, $81, $00
; 4+5: Lead2
        dc.b $85, $85, $84, $82, $00, $80, $00
; 6: Accord
        dc.b $88, $58, $37, $56, $85, $54, $33, $52
        dc.b $81, $80, $00, $80, $00



; =====================================================================
; Percussion instrument definitions (up to 15)
;
; Each percussion instrument is defined by:
; - tt_PercIndexes: The index of the first percussion frame as defined
;       in tt_PercFreqTable and tt_PercCtrlVolTable
; - tt_PercFreqTable: The AUDF frequency value
; - tt_PercCtrlVolTable: The AUDV volume and AUDC values
; =====================================================================

; Indexes into percussion definitions signifying the first frame for
; each percussion in tt_PercFreqTable.
; Caution: Values are stored with an implicit +1 modifier! To get the
; real index, subtract 1.
tt_PercIndexes:
        dc.b $01, $05


; The AUDF frequency values for the percussion instruments.
; If the second to last value is negative (>=128), it means it's an
; "overlay" percussion, i.e. the player fetches the next instrument note
; immediately and starts it in the sustain phase next frame. (Needs
; TT_USE_OVERLAY)
tt_PercFreqTable:
; 0: chikti
        dc.b $01, $01, $03, $00
; 1: Snare
        dc.b $02, $03, $04, $05, $06, $07, $08, $0c
        dc.b $12, $18, $00


; The AUDCx and AUDVx volume values for the percussion instruments.
; - Bits 7..4: AUDC value
; - Bits 3..0: AUDV value
; 0 means end of percussion data.
tt_PercCtrlVolTable:
; 0: chikti
        dc.b $84, $85, $85, $00
; 1: Snare
        dc.b $8f, $8e, $8d, $8c, $8b, $8a, $89, $88
        dc.b $87, $86, $00


        
; =====================================================================
; Track definition
; The track is defined by:
; - tt_PatternX (X=0, 1, ...): Pattern definitions
; - tt_PatternPtrLo/Hi: Pointers to the tt_PatternX tables, serving
;       as index values
; - tt_SequenceTable: The order in which the patterns should be played,
;       i.e. indexes into tt_PatternPtrLo/Hi. Contains the sequences
;       for all channels and sub-tracks. The variables
;       tt_cur_pat_index_c0/1 hold an index into tt_SequenceTable for
;       each channel.
;
; So tt_SequenceTable holds indexes into tt_PatternPtrLo/Hi, which
; in turn point to pattern definitions (tt_PatternX) in which the notes
; to play are specified.
; =====================================================================

; ---------------------------------------------------------------------
; Pattern definitions, one table per pattern. tt_cur_note_index_c0/1
; hold the index values into these tables for the current pattern
; played in channel 0 and 1.
;
; A pattern is a sequence of notes (one byte per note) ending with a 0.
; A note can be either:
; - Pause: Put melodic instrument into release. Must only follow a
;       melodic instrument.
; - Hold: Continue to play last note (or silence). Default "empty" note.
; - Slide (needs TT_USE_SLIDE): Adjust frequency of last melodic note
;       by -7..+7 and keep playing it
; - Play new note with melodic instrument
; - Play new note with percussion instrument
; - End of pattern
;
; A note is defined by:
; - Bits 7..5: 1-7 means play melodic instrument 1-7 with a new note
;       and frequency in bits 4..0. If bits 7..5 are 0, bits 4..0 are
;       defined as:
;       - 0: End of pattern
;       - [1..15]: Slide -7..+7 (needs TT_USE_SLIDE)
;       - 8: Hold
;       - 16: Pause
;       - [17..31]: Play percussion instrument 1..15
;
; The tracker must ensure that a pause only follows a melodic
; instrument or a hold/slide.
; ---------------------------------------------------------------------
TT_FREQ_MASK    = %00011111
TT_INS_HOLD     = 8
TT_INS_PAUSE    = 16
TT_FIRST_PERC   = 17

; vide
tt_pattern0:
        dc.b $2e, $08, $08, $08, $08, $08, $08, $08
        dc.b $08, $08, $08, $08, $08, $08, $08, $08
        dc.b $00

; chikiti
tt_pattern1:
        dc.b $08, $08, $08, $08, $08, $08, $08, $08
        dc.b $08, $08, $11, $11, $11, $08, $11, $08
        dc.b $00

; Basse0a
tt_pattern2:
        dc.b $4d, $08, $4d, $08, $08, $08, $4d, $08
        dc.b $52, $08, $52, $08, $08, $08, $52, $08
        dc.b $4f, $08, $4f, $08, $08, $08, $4f, $08
        dc.b $08, $08, $4f, $08, $50, $08, $4f, $08
        dc.b $00

; Basse0b
tt_pattern3:
        dc.b $4d, $08, $4d, $08, $08, $08, $4d, $08
        dc.b $52, $08, $52, $08, $08, $08, $52, $08
        dc.b $4b, $08, $4b, $08, $08, $08, $4f, $08
        dc.b $08, $08, $4d, $08, $4b, $08, $4f, $08
        dc.b $00

; Basse0c
tt_pattern4:
        dc.b $4d, $08, $4d, $08, $08, $08, $4d, $08
        dc.b $52, $08, $52, $08, $08, $08, $52, $08
        dc.b $4b, $08, $4b, $08, $08, $08, $4f, $08
        dc.b $08, $08, $4d, $08, $4f, $08, $4e, $08
        dc.b $00

; B+mel0a
tt_pattern5:
        dc.b $7a, $08, $4d, $08, $75, $08, $4d, $08
        dc.b $8b, $08, $52, $08, $d7, $08, $52, $08
        dc.b $7d, $08, $4f, $08, $d1, $08, $4f, $08
        dc.b $7a, $08, $4f, $08, $50, $08, $4f, $08
        dc.b $00

; B+mel0b
tt_pattern6:
        dc.b $7d, $08, $4d, $08, $7a, $08, $4d, $08
        dc.b $75, $08, $52, $08, $d7, $08, $52, $08
        dc.b $8b, $08, $4b, $08, $7d, $08, $4f, $08
        dc.b $7a, $08, $4d, $08, $8b, $08, $4f, $08
        dc.b $00

; B+mel0c
tt_pattern7:
        dc.b $7d, $08, $4d, $08, $7a, $08, $4d, $08
        dc.b $71, $08, $52, $08, $7a, $08, $52, $08
        dc.b $7d, $08, $4b, $08, $7a, $08, $4f, $08
        dc.b $7a, $08, $4d, $08, $4f, $08, $4e, $08
        dc.b $00

; B+mel1a
tt_pattern8:
        dc.b $71, $08, $4d, $08, $6e, $08, $4d, $08
        dc.b $6c, $08, $52, $08, $71, $08, $52, $08
        dc.b $6e, $08, $4f, $08, $73, $08, $4f, $08
        dc.b $71, $08, $4f, $08, $50, $08, $4f, $08
        dc.b $00

; B+mel1b
tt_pattern9:
        dc.b $71, $08, $4d, $08, $73, $08, $4d, $08
        dc.b $71, $08, $52, $08, $77, $08, $52, $08
        dc.b $73, $08, $4b, $08, $71, $08, $4f, $08
        dc.b $71, $08, $4d, $08, $6e, $08, $4f, $08
        dc.b $00

; B+mel1c
tt_pattern10:
        dc.b $6c, $08, $4d, $08, $71, $08, $4d, $08
        dc.b $6e, $08, $52, $08, $73, $08, $52, $08
        dc.b $7d, $08, $4b, $08, $7a, $08, $4f, $08
        dc.b $7a, $08, $4d, $08, $4f, $08, $4e, $08
        dc.b $00

; mel2a
tt_pattern11:
        dc.b $71, $08, $08, $08, $6e, $08, $08, $08
        dc.b $6c, $08, $08, $08, $71, $08, $08, $08
        dc.b $6e, $08, $08, $08, $73, $08, $08, $08
        dc.b $71, $08, $d1, $08, $da, $d7, $d3, $08
        dc.b $00

; mel2b
tt_pattern12:
        dc.b $71, $08, $71, $08, $d7, $08, $73, $08
        dc.b $08, $08, $73, $08, $73, $08, $73, $08
        dc.b $71, $08, $71, $08, $08, $08, $73, $08
        dc.b $6e, $08, $ce, $08, $73, $08, $d1, $08
        dc.b $00

; mel2c
tt_pattern13:
        dc.b $6c, $08, $6c, $08, $bd, $08, $6e, $08
        dc.b $6c, $08, $bf, $08, $71, $08, $bd, $08
        dc.b $6e, $08, $d1, $08, $7a, $08, $d3, $08
        dc.b $7a, $08, $7a, $08, $75, $08, $7d, $08
        dc.b $00

; pompeD
tt_pattern14:
        dc.b $08, $08, $eb, $08, $12, $08, $eb, $08
        dc.b $08, $08, $eb, $08, $12, $08, $eb, $08
        dc.b $08, $08, $ec, $08, $12, $08, $ec, $08
        dc.b $08, $08, $ec, $08, $12, $08, $ec, $08
        dc.b $08, $08, $eb, $08, $12, $08, $eb, $08
        dc.b $08, $08, $eb, $08, $12, $08, $eb, $08
        dc.b $08, $08, $ea, $08, $12, $08, $ea, $08
        dc.b $08, $08, $ec, $08, $12, $08, $ec, $08
        dc.b $00

; pompeDmel1a
tt_pattern15:
        dc.b $b3, $08, $eb, $08, $12, $08, $eb, $08
        dc.b $b1, $08, $eb, $08, $12, $08, $eb, $08
        dc.b $b7, $08, $ec, $08, $12, $08, $ec, $08
        dc.b $b3, $08, $ec, $08, $12, $08, $ec, $08
        dc.b $00

; pompeDmel1b
tt_pattern16:
        dc.b $b3, $08, $eb, $08, $12, $08, $eb, $08
        dc.b $b1, $08, $eb, $08, $12, $08, $eb, $08
        dc.b $ae, $08, $ea, $08, $12, $08, $ea, $08
        dc.b $b3, $08, $ec, $08, $12, $08, $ec, $08
        dc.b $00

; pompeDmel1c
tt_pattern17:
        dc.b $b3, $08, $eb, $08, $12, $08, $eb, $08
        dc.b $b1, $08, $eb, $08, $12, $08, $eb, $08
        dc.b $ae, $08, $ea, $08, $12, $08, $ea, $08
        dc.b $ac, $08, $ec, $ae, $12, $08, $ec, $08
        dc.b $00

; pompeD+B0a
tt_pattern18:
        dc.b $4d, $08, $eb, $b1, $12, $08, $eb, $ae
        dc.b $52, $08, $eb, $b3, $12, $08, $eb, $b1
        dc.b $4f, $08, $ec, $b3, $12, $08, $ec, $b1
        dc.b $ae, $ac, $ec, $b3, $12, $08, $ec, $b1
        dc.b $00

; pompeD+B0b
tt_pattern19:
        dc.b $4d, $08, $eb, $b1, $12, $08, $eb, $ac
        dc.b $52, $08, $eb, $ae, $12, $08, $eb, $af
        dc.b $4b, $08, $ea, $ae, $12, $08, $ea, $ae
        dc.b $b1, $ac, $ec, $af, $12, $08, $ec, $ae
        dc.b $00

; pompeD+B0c
tt_pattern20:
        dc.b $4d, $08, $eb, $ac, $12, $08, $eb, $b1
        dc.b $52, $08, $eb, $ae, $12, $08, $eb, $b1
        dc.b $4b, $08, $ea, $ae, $12, $08, $ea, $b1
        dc.b $ae, $af, $ec, $b3, $12, $08, $ec, $ae
        dc.b $00




; Individual pattern speeds (needs TT_GLOBAL_SPEED = 0).
; Each byte encodes the speed of one pattern in the order
; of the tt_PatternPtr tables below.
; If TT_USE_FUNKTEMPO is 1, then the low nibble encodes
; the even speed and the high nibble the odd speed.
    IF TT_GLOBAL_SPEED = 0
tt_PatternSpeeds:
%%PATTERNSPEEDS%%
    ENDIF


; ---------------------------------------------------------------------
; Pattern pointers look-up table.
; ---------------------------------------------------------------------
tt_PatternPtrLo:
        dc.b <tt_pattern0, <tt_pattern1, <tt_pattern2, <tt_pattern3
        dc.b <tt_pattern4, <tt_pattern5, <tt_pattern6, <tt_pattern7
        dc.b <tt_pattern8, <tt_pattern9, <tt_pattern10, <tt_pattern11
        dc.b <tt_pattern12, <tt_pattern13, <tt_pattern14, <tt_pattern15
        dc.b <tt_pattern16, <tt_pattern17, <tt_pattern18, <tt_pattern19
        dc.b <tt_pattern20
tt_PatternPtrHi:
        dc.b >tt_pattern0, >tt_pattern1, >tt_pattern2, >tt_pattern3
        dc.b >tt_pattern4, >tt_pattern5, >tt_pattern6, >tt_pattern7
        dc.b >tt_pattern8, >tt_pattern9, >tt_pattern10, >tt_pattern11
        dc.b >tt_pattern12, >tt_pattern13, >tt_pattern14, >tt_pattern15
        dc.b >tt_pattern16, >tt_pattern17, >tt_pattern18, >tt_pattern19
        dc.b >tt_pattern20        


; ---------------------------------------------------------------------
; Pattern sequence table. Each byte is an index into the
; tt_PatternPtrLo/Hi tables where the pointers to the pattern
; definitions can be found. When a pattern has been played completely,
; the next byte from this table is used to get the address of the next
; pattern to play. tt_cur_pat_index_c0/1 hold the current index values
; into this table for channels 0 and 1.
; If TT_USE_GOTO is used, a value >=128 denotes a goto to the pattern
; number encoded in bits 6..0 (i.e. value AND %01111111).
; ---------------------------------------------------------------------
tt_SequenceTable:
        ; ---------- Channel 0 ----------
        dc.b $00, $01, $00, $01, $00, $01, $00, $01
        dc.b $02, $03, $02, $04, $02, $03, $02, $04
        dc.b $05, $06, $05, $07, $05, $06, $05, $07
        dc.b $08, $09, $08, $0a, $0b, $0c, $0b, $0d
        dc.b $88

        
        ; ---------- Channel 1 ----------
        dc.b $0e, $0e, $0e, $0e, $0f, $10, $0f, $11
        dc.b $12, $13, $12, $14, $12, $13, $12, $14
        dc.b $12, $13, $12, $14, $0f, $10, $0f, $11
        dc.b $a3


        echo "Track size: ", *-tt_TrackDataStart
