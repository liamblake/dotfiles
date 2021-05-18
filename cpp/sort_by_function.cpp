/**
 * @brief Sort a list of class pointers according to the value returned by a
 * specified method.
 *
 * @tparam T The class type to be sorted.
 * @tparam S The return type of the member function to sort the list by. The
 * comparison operator > must be defined for S and the list is sorted with
 * respect to this comparison.
 * @param array
 * @param len
 * @param f
 * @param inplace Whether to perform the sort in-place. If true, the original
 * array is returned and quicksort is used. If false, a new array is dynamically
 * allocated and insertion sort is used.
 * @return T*
 */
template <class T, typename S>
T* sort_by_func(T** array, int len, S (*f)(void), bool inplace = false) {
    // Helpers
    void swap(T * *arr, idx1, idx2) {
        T tmp = array[idx1];
        array[idx1] = array[idx2];
        array[idx2] = tmp;
    }

    int partition(T * *arr, int low, int high) {
        T* pivot = arr[high]; // pivot
        int i = (low - 1);    // Index of smaller element

        for (int j = low; j <= high - 1; j++) {
            // If current element is smaller than or
            // equal to pivot
            if (arr[j] <= pivot) {
                i++; // increment index of smaller element
                swap(&arr[i], &arr[j]);
            }
        }
        swap(&arr[i + 1], &arr[high]);
        return (i + 1);
    }

    void quick_sort(T * *arr, int low, int high) {
        if (low < high) {
            /* pi is partitioning index, arr[p] is now
               at right place */
            int pi = partition(arr, low, high);

            // Separately sort elements before
            // partition and after partition
            quick_sort(arr, low, pi - 1);
            quick_sort(arr, pi + 1, high);
        }
    }

    if (inplace) {
        // Quicksort

        return array;
    } else {
        // Create the new array
        T** sorted = new T[len];
        for (int i = 0; i < len; i++) {
            T* x = array[i];
            int j = i - 1;
            while (j >= 0 && sorted[j]->f > x->f) {
                sorted[j + 1] = sorted[j];
                j = j - 1;
            }
            sorted[j + 1] = x;
        }

        return sorted;
    }
}
