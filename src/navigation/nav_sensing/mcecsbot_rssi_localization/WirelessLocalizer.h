#ifndef WIRELESS_LOCALIZER
#define WIRELESS_LOCALIZER

#define SIGNAL_CUTOFF_LOW   -100
#define SIGNAL_CUTOFF_HIGH  -20
#define SIGNAL_CUTOFF_STEP  5

#include <vector>
#include "WAP.h"

using namespace std;

struct Coordinates
{
  float x;
  float y;
  float z;
};

struct Bounds
{
  float xLength;
  float yLength;
  float zLength;
};

class WirelessLocalizer
{
  public:
    WirelessLocalizer();
    ~WirelessLocalizer();
    //float GetRectangleDepth();
    //float GetRectangleDepthMax();
    float GetRectangleHeight();
    float GetRectangleHeightMax();
    float GetRectangleWidth();
    float GetRectangleWidthMax();
    void Localize();
    void PrintCenterPoints();
    void PrintDatabaseResults();
    void PrintMatches();
    void PrintScannedResults();

  private:
    vector<Coordinates> *centerPoints;          // Format of individual array is [x,y,z]
    vector<Bounds> *rectangleLengths;      // Format of individual array is [x,y]
    vector<WAP> *dbResults;
    vector<WAP> *matchedNodes;             // Matches between db and scan results
    vector<WAP> *scanResults;

    /*
     * Each node chosen for the outer bound for the respective axis gets
     * stored in these vectors. The first node in the vector will always be
     * that of the largest area, and the most narrowed down boundary is
     * at the end of the vector.
     */
    vector<WAP> *xOuterBoundsHistory;
    vector<WAP> *yOuterBoundsHistory;
    vector<WAP> *zOuterBoundsHistory;
};

#endif