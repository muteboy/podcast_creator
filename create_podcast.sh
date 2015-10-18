#!/bin/bash
#Create_Coiled_Spring_Episode.sh

echo -----------------------------------------------------

cs_set_variables() {
    #ask from user?
    echo "Please enter episode number: "
    read CS_Episode_Number
    script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/"
    general_source_files_folder="${script_dir}general_source_files/"
    episode_source_files_folder="${script_dir}source_files_ep_${CS_Episode_Number}/"
    echo Folders: $script_dir, $general_source_files_folder, $episode_source_files_folder
    CS_Episode_Title=$(head -n 1 ${episode_source_files_folder}episode_title.txt)
    echo Episode details: Episode ${CS_Episode_Number} - ${CS_Episode_Title}
    id3_artist="Matthew Petty"
    id3_album="Coiled Spring"
    CS_Episode_Colour="hsb($((RANDOM%255)),255,100)"
    espeak_voice="english-mb-en1"
    espeak_variables="-v${espeak_voice} -p 50 -s 140 -k 1 -m -w"
    gen_date_time=$(date +"%A %B %d %Y, %I:%M %p")
    echo $gen_date_time
}

cs_set_filenames() {
    # graphics filenames
    graphics_file_format_extension=".png"
    file_suffix=""
    final_image="CS_Ep_${CS_Episode_Number}_Cover_Art_Final${file_suffix}${graphics_file_format_extension}"
    text_cs_filename="CS_Ep_${CS_Episode_Number}_Graphics_Temp_CS_Text${file_suffix}${graphics_file_format_extension}"
    text_sl_filename="CS_Episode_${CS_Episode_Number}_Graphics_Temp_Slogan_Text${file_suffix}${graphics_file_format_extension}"
    text_ep_filename="CS_Episode_${CS_Episode_Number}_Graphics_Temp_Ep_Text${file_suffix}${graphics_file_format_extension}"
    text_num_filename="CS_Episode_${CS_Episode_Number}_Graphics_Temp_Num_Text${file_suffix}${graphics_file_format_extension}"
    text_num_filename_2="CS_Episode_${CS_Episode_Number}_Graphics_Temp_Num_Text_2${file_suffix}${graphics_file_format_extension}"
    background_filename="CS_Episode_${CS_Episode_Number}_Graphics_Temp_Background${file_suffix}${graphics_file_format_extension}"
    logo_filename="CS_Episode_${CS_Episode_Number}_Graphics_Temp_Logo${file_suffix}${graphics_file_format_extension}"
    body_filename="CS_Episode_${CS_Episode_Number}_Graphics_Temp_Body${file_suffix}${graphics_file_format_extension}"
    art_filename="CS_Episode_${CS_Episode_Number}_Graphics_Temp_Art${file_suffix}${graphics_file_format_extension}"
    input_art_filename="${episode_source_files_folder}Input_Art${file_suffix}${graphics_file_format_extension}"
    text_curve_1="CS_Episode_${CS_Episode_Number}_Graphics_Temp_Slogan_Curve_Text_1${file_suffix}${graphics_file_format_extension}"
    text_curve_2="CS_Episode_${CS_Episode_Number}_Graphics_Temp_Slogan_Curve_Text_2${file_suffix}${graphics_file_format_extension}"
    # audio filenames
    original_music_filename="${general_source_files_folder}New_Friendly-44100.wav"
    credits_music_filename="${general_source_files_folder}CS_Credits_Music_original.wav"
    speech_num="CS_Ep_${CS_Episode_Number}_Audio_Temp_Speech_Number.wav"
    #speech_intro="CS_Ep_${CS_Episode_Number}_Audio_Temp_Speech_Intro.wav"
    speech_intro_with_music="CS_Ep_${CS_Episode_Number}_Audio_Temp_Speech_Intro_with_Music.wav"
    speech_intro="${episode_source_files_folder}intro.wav"
    speech_outro="${episode_source_files_folder}outro.wav"
    speech_1="${episode_source_files_folder}part1.wav"
    speech_2="${episode_source_files_folder}part2.wav"
    speech_3="${episode_source_files_folder}part3.wav"
    speech_credits="CS_Credits_Music_Audio_Temp.wav"
    speech_logotone="CS_Ep_${CS_Episode_Number}_Audio_Temp_Speech_Logotone.wav"
    logotone="CS_Ep_${CS_Episode_Number}_Audio_Temp_Logotone.wav"
    music="${general_source_files_folder}CS_Theme_Music.wav"
    final_wav="CS_Ep_${CS_Episode_Number}_Final.wav"
    final_mp3="CS_Ep_${CS_Episode_Number}_Final.mp3"
}

cs_art_background() {
    convert -size 550x550 canvas:${CS_Episode_Colour} ${background_filename}
    echo background created $CS_Episode_Colour
}

cs_art_texts() {
    #pixels across: 15+80+15+425+15 = 110+425+15 = 550
    #pixels down: 15+80+15+2+rest = 110+2+rest = 550
    convert -background none -fill white -font FreeSans-Bold -size 280 label:"Coiled Spring" -blur 0.7x0.7 -sharpen 0x8 $text_cs_filename
    convert -background none -fill white -font FreeSans-Bold -size x35 label:"${CS_Episode_Title}" -blur 0.7x0.7 -sharpen 0x8 $text_ep_filename
    convert -background none -fill 'rgba(255,255,255,100)' -font FreeSans-Bold -gravity center -kerning -30 -size 530x418 label:"${CS_Episode_Number}" -blur 1 -sharpen 0x8 ${text_num_filename}
    convert -background none -fill white -font FreeSans-Bold -gravity center -size 80x30 label:"#${CS_Episode_Number}" ${text_num_filename_2}
    convert -background none -fill white -font FreeSans-Bold -pointsize 15 label:'• the podcast •' -virtual-pixel Background -distort Arc 180 ${text_curve_1}
    convert -background none -fill white -font FreeSans-Bold -pointsize 15 label:' with potential ' -virtual-pixel Background -rotate 180 -distort Arc '180 180' ${text_curve_2}
    echo all text created
}

cs_art_logo()    {
    convert -size 200x200 xc:none -antialias -fill none -stroke white -strokewidth 6 -draw "translate 3,3 circle 16,16 16,0 ellipse 16,48 16,16 90,270 ellipse 16,80 16,16 90,270 circle 176,176 176,192 ellipse 16,112 16,16 90,270 ellipse 16,144 16,16 90,270 ellipse 16,176 16,16 90,270 ellipse 176,16 16,16 270,90 ellipse 176,48 16,16 270,90 ellipse 176,80 16,16 270,90 ellipse 176,112 16,16 270,90 ellipse 176,144 16,16 270,90 line 16,0 176,0 line 16,192 176,192 line 16,32 176,0 line 16,64 176,32 line 16,96 176,64 line 16,128 176,96 line 16,160 176,128 line 16,192 176,160" -stroke white -strokewidth 2 -draw "translate 3,3 line 8,24 24,8 line 184,168 168,184 line 4,18 18,4 line 14,28 28,14 line 180,162 162,180 line 190,172 172,190" -blur 10 -sharpen 0x12 -resize 80x80 $logo_filename
    echo logo created
}

cs_art_cover() {
    #convert ${input_art_filename} -monochrome -morphology Erode Disk -transparent white ${art_filename}
    #convert ${input_art_filename} -colorspace gray -ordered-dither 8x1 -transparent white ${art_filename}
    #convert ${input_art_filename} -monochrome -morphology Dilate Diamond -morphology Erode Diamond -transparent white ${art_filename}
    #convert ${input_art_filename} -colorspace gray  +dither -colors 2 -normalize -transparent white ${art_filename}
    #convert ${input_art_filename} -colorspace sRGB -modulate 50,200,100 -alpha set -channel A -evaluate Divide 1.2 ${art_filename}
    #convert ${input_art_filename} ( -clone 0 -fill "#a0132e" -colorize 100 ) ( -clone 0,1 -compose difference -composite -separate +channel -evaluate-sequence max -auto-level ) -delete 1 -alpha off -compose over -compose copy_opacity -composite ${art_filename}
    convert                    \
    ${input_art_filename}      \
    -colorspace gray           \
    \(                         \
       -clone 0                \
       -fill "#ffffff"         \
       -colorize 100           \
    \)                         \
    \(                         \
       -clone 0,1              \
       -compose difference     \
       -composite              \
       -separate               \
       +channel                \
       -evaluate-sequence max  \
       -auto-level             \
    \)                         \
     -delete 1                 \
     -alpha off                \
     -compose over             \
     -compose copy_opacity     \
     -composite                \
     -equalize                 \
    ${art_filename}
    #convert ${art_filename} -ordered-dither 4x1 ${art_filename}
    #convert ${input_art_filename} -colorspace gray -fuzz 20% -transparent white ${art_filename}
    echo created art
}
   
cs_art_combine() {
    # line
    convert $background_filename -fill none -stroke white -strokewidth 1.5 -draw "path 'M 0,110 L 550,110'" $final_image
    # logo and texts
    composite $logo_filename $final_image -geometry +15+15 -compose Over $final_image
    composite $text_cs_filename $final_image -geometry +110+12 -compose Over $final_image
    composite $text_ep_filename $final_image -geometry +110+62 -compose Over $final_image
    composite $text_num_filename $final_image -geometry +0+111 -compose Over $final_image
    composite $text_num_filename_2 $final_image -geometry +455+40 -compose Over $final_image
    composite $text_curve_1 $final_image -geometry +452+12 -compose Over $final_image
    composite $text_curve_2 $final_image -geometry +452+53 -compose Over $final_image
    # cover art
    composite $art_filename $final_image -geometry +0+111 -compose Over $final_image
    # noise
    convert $final_image -evaluate gaussian-noise 0.1 $final_image
    echo cover art created
}

cs_audio_speech() {
    espeak ${espeak_variables}${speech_num} "Coiled Spring, Episode ${CS_Episode_Number}. Created ${gen_date_time}"
    espeak ${espeak_variables}${speech_logotone} "You're listening to the Coiled Spring."
    echo all speech created
}

cs_audio_fix_existing() {
    # fetch parts
    cp ${episode_source_files_folder}intro.wav ${script_dir}intro.wav
    cp ${episode_source_files_folder}part1.wav ${script_dir}part1.wav
    cp ${episode_source_files_folder}part2.wav ${script_dir}part2.wav
    cp ${episode_source_files_folder}part3.wav ${script_dir}part3.wav
    cp ${episode_source_files_folder}outro.wav ${script_dir}outro.wav
    # episode number speech
    sox -S ${speech_num} -c 1 -r 48000 ${script_dir}temp.wav
    mv ${script_dir}temp.wav ${speech_num}
    # original music
    sox -S ${original_music_filename} -c 1 -r 48000 ${music}
    # credits music
    sox -S ${credits_music_filename} -c 1 -r 48000 ${speech_credits}
    # intro speech
    sox -S ${speech_intro} -c 1 -r 48000 ${script_dir}temp.wav
    mv ${script_dir}temp.wav ${speech_intro}
    # outro speech
        sox -S ${speech_outro} -c 1 -r 48000 ${script_dir}temp.wav
    mv ${script_dir}temp.wav ${speech_outro}
    # speech 1
    sox -S ${speech_1} -c 1 -r 48000 temp.wav
    mv temp.wav ${speech_1}
    # speech 2
    sox -S ${speech_2} -c 1 -r 48000 temp.wav
    mv temp.wav ${speech_2}
    # speech 3
    sox -S ${speech_3} -c 1 -r 48000 temp.wav
    mv temp.wav ${speech_3}
    # done
    echo fixed existing files
}

cs_audio_logotone() {       
    #set up
    sox ${speech_logotone} -r 48000 temp.wav gain -n -1
    mv temp.wav ${speech_logotone}
    logotone_speech_length=$(soxi -s ${speech_logotone})
    logotone_beep_limit_high=400
    logotone_beep_limit_low=200
    logotone_beep_count=20
    logotone_pad=$((logotone_speech_length/2))
    let logotone_speech_length=logotone_speech_length+logotone_pad+logotone_pad
    logotone_beep_length=10000
    #loop
    logotone="CS_Ep_${CS_Episode_Number}_Logotone.wav"
    beep_counter=1
    while [ $beep_counter -le $logotone_beep_count ]
        do
        beep_frequency=$((RANDOM%logotone_beep_limit_high+logotone_beep_limit_low))
        sox -n -r 48000 -c 1 logotone_beep_${beep_counter}.wav synth ${logotone_beep_length}s sine ${beep_frequency} gain -n -10
        sox logotone_beep_${beep_counter}.wav tempbeep.wav fade q 20s 0 20s
        mv tempbeep.wav logotone_beep_${beep_counter}.wav
        let beep_counter=beep_counter+1
    done
     # combine beeps and speech to create logotone
    sox --combine concatenate $(ls logotone_beep_*.wav | sort -n) all_logotone_beeps.wav reverb
    rm logotone_beep_*.wav
    sox ${speech_logotone} tempspeech.wav pad ${logotone_pad}s ${logotone_pad}s
    mv tempspeech.wav ${speech_logotone}
    sox -m all_logotone_beeps.wav ${speech_logotone} ${logotone} fade $((logotone_pad/2))s 0 $((logotone_pad/2))s
    rm all_logotone_beeps.wav
    echo logotone ${logotone} created
}

cs_audio_mix_intro() {
    echo chop and mix start music and intro
    # set marks
    let mark1=0
    let mark2=20
    let mark3=30
    # chop up
    sox ${music} music_1.wav trim =$mark1 =$mark2
    # chop up and fade
    sox ${music} music_2.wav trim =$mark2 =$mark3 vol 0.2 fade t 0 0 3
    sox music_1.wav music_2.wav music_faded.wav
    # pad speech
    sox ${speech_intro} temppadded.wav pad 20.5 0
    sox -m music_faded.wav temppadded.wav ${speech_intro_with_music}
    echo chopped up music
}

cs_audio_concat_process() {
    echo starting concatenation
    sox -S ${speech_num} ${speech_intro_with_music} ${logotone} ${speech_1} ${logotone} ${speech_2} ${logotone} ${speech_3} ${logotone} ${speech_outro} ${speech_credits} ${final_wav}
    #sox ${final_wav} ${final_mp3} compand 0.3,1 6:-70,-60,-20 -5 -90 0.2 norm -1
    sox -S ${final_wav} ${final_mp3} norm -1 compand 0.02,0.20 5:-60,-40,-10 -5 -90 0.1
    echo mp3 compiled
    soxi ${final_mp3}
}

cs_audio_tag() {
    eyeD3 -a "${id3_artist}" -A "${id3_album}" -t "Coiled Spring - Episode ${CS_Episode_Number} - ${CS_Episode_Title}" -n ${CS_Episode_Number} ${final_mp3} >/dev/null
    eyeD3 --add-image :FRONT_COVER ${final_mp3} >/dev/null
    eyeD3 --add-image ${final_image}:FRONT_COVER ${final_mp3} >/dev/null
    echo mp3 tagged
}

cs_delete_working() {
    rm $background_filename $text_cs_filename $text_ep_filename $logo_filename $text_num_filename $art_filename $text_num_filename_2
    rm $speech_num $speech_credits $speech_logotone
    rm $text_curve_1 $text_curve_2
    rm $logotone music_1.wav music_2.wav music_faded.wav $final_wav $speech_intro_with_music $music
    rm part1.wav part2.wav part3.wav intro.wav outro.wav
    rm temppadded.wav
    echo working files deleted
}

cs_set_variables
cs_set_filenames
cs_art_background
cs_art_texts
cs_art_logo
cs_art_cover
cs_art_combine
cs_audio_speech
cs_audio_fix_existing
cs_audio_logotone
cs_audio_mix_intro
cs_audio_concat_process
cs_audio_tag
cs_delete_working

echo -----------------------------------------------------
