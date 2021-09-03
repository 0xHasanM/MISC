import wave, struct
def read_frame():
	wavefile = wave.open('sound.wav', 'r')
	length = wavefile.getnframes()
	frames = []
	for i in range(0, length):
		wavedata = wavefile.readframes(1)
		data = struct.unpack("<h", wavedata)
		frames.append(data[0])
	return frames
def frame_to_wave(frames):
	output = ""
	neg = 0
	pos = 0
	for n in range(len(frames)):
		if n == (len(frames)-1):
			if frames[n] > 0:
				pos += 1
				output += "1"*(pos//47)
			else:
				neg += 1
				output += "0"*(neg//47)
		else:
			if frames[n] < 0:
				neg += 1
				if frames[n+1] > 0:
					output += "0"*(neg//47)
					neg = 0
			else:
				pos += 1
				if frames[n+1] < 0:
					output += "1"*(pos//47)
					pos = 0
	return output
def binary_2_ascii(output):
	binary_int = int(output, 2);
	byte_number = binary_int.bit_length() + 7 // 8
	binary_array = binary_int.to_bytes(byte_number, "big")
	return binary_array.decode()
if __name__ == "__main__":
	print(binary_2_ascii(frame_to_wave(read_frame())))