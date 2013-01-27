//
//  CCDirector+MemoryStats.m
//
//  Created by Torques Inc. on 2013/01/27.
//

#import "CCDirector+MemoryStats.h"
#include <sys/sysctl.h>
#import <mach/mach.h>
#import <mach/mach_host.h>

@implementation CCDirector (MemoryStats)

+(double) getAvailableBytes
{
  vm_statistics_data_t vmStats;
  mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
  kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
	
  if (kernReturn != KERN_SUCCESS)
  {
    return NSNotFound;
  }
	
  return (vm_page_size * vmStats.free_count);
}

+(double) getAvailableKiloBytes
{
  return [CCDirector getAvailableBytes] / 1024.0;
}

+(double) getAvailableMegaBytes
{
  return [CCDirector getAvailableKiloBytes] / 1024.0;
}

+(double) getMemoryActiveBytes
{
	struct task_basic_info info;
	mach_msg_type_number_t size = sizeof(info);
	kern_return_t kerr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
	if( kerr != KERN_SUCCESS ) {
		return NSNotFound;
	}
	
	return info.resident_size;
}

+(double) getMemoryActiveKiloBytes
{
	return [CCDirector getMemoryActiveBytes] / 1024.0;
}

+(double) getMemoryActiveMegaBytes
{
	return [CCDirector getMemoryActiveKiloBytes] / 1024.0;
}

// shows the statistics with memory stats.
-(void) showStats
{
	frames_++;
	accumDt_ += dt;
	
	if( displayStats_ ) {
		// Ms per Frame
		
		if( accumDt_ > CC_DIRECTOR_STATS_INTERVAL)
		{
			/*
			 // top: draws
			 NSString *draws = [[NSString alloc] initWithFormat:@"%4lu", (unsigned long)__ccNumberOfDraws];
			 [drawsLabel_ setString:draws];
			 [draws release];
			 */
			
			// top: active memory
			NSString*	strMem1	= [NSString stringWithFormat:@"%.1f",
													 [CCDirector getMemoryActiveMegaBytes]];
			[drawsLabel_ setString:strMem1];
			
			/*
			// middle: spf
			NSString *spfstr = [[NSString alloc] initWithFormat:@"%.3f", secondsPerFrame_];
			[SPFLabel_ setString:spfstr];
			[spfstr release];
			*/
			
			// middle: available memory
			NSString*	strMem2	= [NSString stringWithFormat:@"%.1f",
													 [CCDirector getAvailableMegaBytes]];
			[SPFLabel_ setString:strMem2];
			
			// bottom: fps
			frameRate_ = frames_/accumDt_;
			frames_ = 0;
			accumDt_ = 0;
			NSString *fpsstr = [NSString stringWithFormat:@"%.1f", frameRate_];
			[FPSLabel_ setString:fpsstr];
		}
		
		[drawsLabel_ visit];
		[FPSLabel_ visit];
		[SPFLabel_ visit];
	}
	
	__ccNumberOfDraws = 0;
}


@end
