void main()
{
    /*
     * The first text cell of video memory (i.e. top left of the screen)
     * is located at address 0xb8000, store the character 'X' at that address,
     * (i.e. display character 'X' at the first text cell).
     */
    char* video_memory = (char*) 0xb8000;
    *video_memory = 'X';
}
