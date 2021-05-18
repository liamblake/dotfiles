template <typename T>
T sample_cdf(T *values, int length, double *dist)
{

    // Generate random number
    double r = ((double)rand() / (RAND_MAX));

    // Iterate through distribution until the first entry greather than r is found
    int i = 0;
    while (++i < length && r > dist[i])
        ;

    return values[i - 1];
}