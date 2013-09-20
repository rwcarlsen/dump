
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>

typedef std::vector<int> Nums;
int read_nums(const char*, Nums&);
void bubble_sort(Nums&);
void quick_sort(Nums&);

int main(int argc, char** argv) {
  if (argc < 2) {
    std::cout << "need file arg\n";
    return 1;
  }

  std::vector<int> nums;
  int nerrs = read_nums(argv[1], nums);
  if (nerrs != 0) {
    std::cout << "failed to parse " << nerrs << " lines\n";
  }

  //bubble_sort(nums);
  quick_sort(nums);
  std::cout << "sorted list:\n";
  for (int i = 0; i < nums.size(); i++) {
    std::cout << "    " << nums[i] << "\n";
  }

  return 0;
}

Nums& quick_sort_inner(Nums& nums) {
  if (nums.size() < 2) {
    return nums;
  }

  int pivot = 0;
  Nums lower;
  Nums upper;
  for (int i = 0; i < nums.size(); i++) {
    if (i == pivot) {
      continue;
    } else if (nums[i] <= nums[pivot]) {
      lower.push_back(nums[i]);
    } else {
      upper.push_back(nums[i]);
    }
  }
  lower = quick_sort_inner(lower);
  upper = quick_sort_inner(upper);
  nums[lower.size()] = nums[pivot];
  for (int i = 0; i < lower.size(); i++) {
    nums[i] = lower[i];
  }
  for (int i = 0; i < upper.size(); i++) {
    nums[lower.size() + i + 1] = upper[i];
  }
  return nums;
}

void quick_sort(Nums& nums) {
  quick_sort_inner(nums);
}

void bubble_sort(Nums& nums) {
  for (int n = 0; n < nums.size(); n++) {
    for (int i = 0; i < nums.size() - 1; i++) {
      if (nums[i] < nums[i+1]) {
        int tmp = nums[i];
        nums[i] = nums[i+1];
        nums[i+1] = tmp;
      }
    }
  }
}

int read_nums(const char* fname, Nums& nums) {
  std::ifstream infile(fname);
  std::string line;
  int nerrs = 0;
  int v;

  while (std::getline(infile, line)) {
    std::istringstream iss(line);
    if (!(iss >> v)) {
      nerrs++;
      continue;
    }
    nums.push_back(v);
  }

  return nerrs;
}

