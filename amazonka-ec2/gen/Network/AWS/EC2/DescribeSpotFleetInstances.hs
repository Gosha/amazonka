{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}

{-# OPTIONS_GHC -fno-warn-unused-binds   #-}
{-# OPTIONS_GHC -fno-warn-unused-matches #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.EC2.DescribeSpotFleetInstances
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- Describes the running instances for the specified Spot fleet.
--
-- <http://docs.aws.amazon.com/AWSEC2/latest/APIReference/ApiReference-query-DescribeSpotFleetInstances.html>
module Network.AWS.EC2.DescribeSpotFleetInstances
    (
    -- * Request
      DescribeSpotFleetInstances
    -- ** Request constructor
    , describeSpotFleetInstances
    -- ** Request lenses
    , dsfirqNextToken
    , dsfirqDryRun
    , dsfirqMaxResults
    , dsfirqSpotFleetRequestId

    -- * Response
    , DescribeSpotFleetInstancesResponse
    -- ** Response constructor
    , describeSpotFleetInstancesResponse
    -- ** Response lenses
    , dsfirsNextToken
    , dsfirsStatus
    , dsfirsSpotFleetRequestId
    , dsfirsActiveInstances
    ) where

import           Network.AWS.EC2.Types
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | Contains the parameters for DescribeSpotFleetInstances.
--
-- /See:/ 'describeSpotFleetInstances' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dsfirqNextToken'
--
-- * 'dsfirqDryRun'
--
-- * 'dsfirqMaxResults'
--
-- * 'dsfirqSpotFleetRequestId'
data DescribeSpotFleetInstances = DescribeSpotFleetInstances'
    { _dsfirqNextToken          :: !(Maybe Text)
    , _dsfirqDryRun             :: !(Maybe Bool)
    , _dsfirqMaxResults         :: !(Maybe Int)
    , _dsfirqSpotFleetRequestId :: !Text
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'DescribeSpotFleetInstances' smart constructor.
describeSpotFleetInstances :: Text -> DescribeSpotFleetInstances
describeSpotFleetInstances pSpotFleetRequestId_ =
    DescribeSpotFleetInstances'
    { _dsfirqNextToken = Nothing
    , _dsfirqDryRun = Nothing
    , _dsfirqMaxResults = Nothing
    , _dsfirqSpotFleetRequestId = pSpotFleetRequestId_
    }

-- | The token for the next set of results.
dsfirqNextToken :: Lens' DescribeSpotFleetInstances (Maybe Text)
dsfirqNextToken = lens _dsfirqNextToken (\ s a -> s{_dsfirqNextToken = a});

-- | Checks whether you have the required permissions for the action, without
-- actually making the request, and provides an error response. If you have
-- the required permissions, the error response is @DryRunOperation@.
-- Otherwise, it is @UnauthorizedOperation@.
dsfirqDryRun :: Lens' DescribeSpotFleetInstances (Maybe Bool)
dsfirqDryRun = lens _dsfirqDryRun (\ s a -> s{_dsfirqDryRun = a});

-- | The maximum number of results to return in a single call. Specify a
-- value between 1 and 1000. The default value is 1000. To retrieve the
-- remaining results, make another call with the returned @NextToken@
-- value.
dsfirqMaxResults :: Lens' DescribeSpotFleetInstances (Maybe Int)
dsfirqMaxResults = lens _dsfirqMaxResults (\ s a -> s{_dsfirqMaxResults = a});

-- | The ID of the Spot fleet request.
dsfirqSpotFleetRequestId :: Lens' DescribeSpotFleetInstances Text
dsfirqSpotFleetRequestId = lens _dsfirqSpotFleetRequestId (\ s a -> s{_dsfirqSpotFleetRequestId = a});

instance AWSRequest DescribeSpotFleetInstances where
        type Sv DescribeSpotFleetInstances = EC2
        type Rs DescribeSpotFleetInstances =
             DescribeSpotFleetInstancesResponse
        request = post
        response
          = receiveXML
              (\ s h x ->
                 DescribeSpotFleetInstancesResponse' <$>
                   (x .@? "nextToken") <*> (pure (fromEnum s)) <*>
                     (x .@ "spotFleetRequestId")
                     <*>
                     (x .@? "activeInstanceSet" .!@ mempty >>=
                        parseXMLList "item"))

instance ToHeaders DescribeSpotFleetInstances where
        toHeaders = const mempty

instance ToPath DescribeSpotFleetInstances where
        toPath = const "/"

instance ToQuery DescribeSpotFleetInstances where
        toQuery DescribeSpotFleetInstances'{..}
          = mconcat
              ["Action" =:
                 ("DescribeSpotFleetInstances" :: ByteString),
               "Version" =: ("2015-04-15" :: ByteString),
               "NextToken" =: _dsfirqNextToken,
               "DryRun" =: _dsfirqDryRun,
               "MaxResults" =: _dsfirqMaxResults,
               "SpotFleetRequestId" =: _dsfirqSpotFleetRequestId]

-- | Contains the output of DescribeSpotFleetInstances.
--
-- /See:/ 'describeSpotFleetInstancesResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dsfirsNextToken'
--
-- * 'dsfirsStatus'
--
-- * 'dsfirsSpotFleetRequestId'
--
-- * 'dsfirsActiveInstances'
data DescribeSpotFleetInstancesResponse = DescribeSpotFleetInstancesResponse'
    { _dsfirsNextToken          :: !(Maybe Text)
    , _dsfirsStatus             :: !Int
    , _dsfirsSpotFleetRequestId :: !Text
    , _dsfirsActiveInstances    :: ![ActiveInstance]
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'DescribeSpotFleetInstancesResponse' smart constructor.
describeSpotFleetInstancesResponse :: Int -> Text -> DescribeSpotFleetInstancesResponse
describeSpotFleetInstancesResponse pStatus_ pSpotFleetRequestId_ =
    DescribeSpotFleetInstancesResponse'
    { _dsfirsNextToken = Nothing
    , _dsfirsStatus = pStatus_
    , _dsfirsSpotFleetRequestId = pSpotFleetRequestId_
    , _dsfirsActiveInstances = mempty
    }

-- | The token required to retrieve the next set of results. This value is
-- @null@ when there are no more results to return.
dsfirsNextToken :: Lens' DescribeSpotFleetInstancesResponse (Maybe Text)
dsfirsNextToken = lens _dsfirsNextToken (\ s a -> s{_dsfirsNextToken = a});

-- | FIXME: Undocumented member.
dsfirsStatus :: Lens' DescribeSpotFleetInstancesResponse Int
dsfirsStatus = lens _dsfirsStatus (\ s a -> s{_dsfirsStatus = a});

-- | The ID of the Spot fleet request.
dsfirsSpotFleetRequestId :: Lens' DescribeSpotFleetInstancesResponse Text
dsfirsSpotFleetRequestId = lens _dsfirsSpotFleetRequestId (\ s a -> s{_dsfirsSpotFleetRequestId = a});

-- | The running instances. Note that this list is refreshed periodically and
-- might be out of date.
dsfirsActiveInstances :: Lens' DescribeSpotFleetInstancesResponse [ActiveInstance]
dsfirsActiveInstances = lens _dsfirsActiveInstances (\ s a -> s{_dsfirsActiveInstances = a});